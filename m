Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUJHAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUJHAVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269873AbUJGW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:56:57 -0400
Received: from smtp06.auna.com ([62.81.186.16]:55732 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S268144AbUJGWl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:41:26 -0400
Date: Thu, 07 Oct 2004 22:41:23 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc3-mm3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<200410071041.20723.sandersn@btinternet.com>
	<20041007025007.77ec1a44.akpm@osdl.org>
	<20041007114040.GV9106@holomorphy.com>
	<1097184341l.10532l.0l@werewolf.able.es>
	<1097185597l.10532l.1l@werewolf.able.es>
	<20041007150708.5d60e1c3.akpm@osdl.org>
In-Reply-To: <20041007150708.5d60e1c3.akpm@osdl.org> (from akpm@osdl.org on
	Fri Oct  8 00:07:08 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097188883l.6408l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-yHUguVYJujXSrSqPD7ta"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-yHUguVYJujXSrSqPD7ta
Content-Type: text/plain; charset=ISO-8859-1; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.10.08, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On 2004.10.07, J.A. Magallon wrote:
> > >=20
> > > This conflicts with kernel/irq/proc.c:
> > >=20
> > > 	unsigned long prof_cpu_mask =3D -1;
> > >=20
> > > Shouldn't this be:
> > >=20
> > > 	cpumask_t prof_cpu_mask =3D CPU_MASK_NONE;
> > >=20
> > > This will show problems when NR_CPUS > sizeof(long)....
> > >=20
> >=20
> > Err....
> >=20
> > There is a problem with this -mm:
>=20
> Yes, there seems to be a mingo/wli bunfight over prof_cpu_mask.
>=20
> Something like this, I think:
>=20

Thanks, that made it work again !!

Total set of patches to boot:
- your latest fix
- revert optimize profile + Andi's patch
- uhci fix (still needed ?)
- e100 fix (only thing I have seen at the moment...)
- 1Gb lowmem

How about including the last one in -mm, for testing ? I use it in a server
and in my home workstation and it works fine (even with nvidia drivers ;) )=
.

Everything attached (they are really small...)

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


--=-yHUguVYJujXSrSqPD7ta
Content-Type: application/x-bzip; name=10-irq-cpumask.bz2
Content-Disposition: attachment; filename=10-irq-cpumask.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWeIu41kAAN7fgEAweX//32un/U6/7//rUANZI9ZgNCg0hoJok9Q9TyammmmQaaaP
UAZA09I9TMp6gHDTTIxGE0wEMAmmEYJiZDTI0NAJTREaRlT0eSeUmyg9NQAZNDQwQABoHDTTIxGE
0wEMAmmEYJiZDTI0NAJIiDQE0aaTSY0JoGjQZADQeoDQ9ImgTBcw6QkL5+12CEJEhCEW3bkTlrK1
8tb9GylB+GILNeTO0pUN9QhJLrTpxf1DKU5qomHJX1LEpESAJSsCYjIRljQiY9DRXUuu6bB+t+IE
rM93Llle68UaFOEPhAGUQZMl+6IYRL7oEci5DxCQCfiqhtDxNatLvVBWKuV34r/dJRqaq99DSbBa
a5tXK1OixQlKT8HbjNNyUhLzlm9dCY2oyvzxgjEgHRvdg43p2S6yWbzTkd/OhMBtRGTq92KWaM+M
WzHgO1trjuck+Q2D2iA4rmd0Yg1G/XZOls1lz4rSt03IN/LKi0nfPh1GGsg9ZTVinURBwu6TFCll
UVUJROFYQ0KYRbJ63seGpaJ0T214L+GLfm4RoQk2NwrRgVtAiktG4BjAB4gEFqo0qDE7J6aafp1K
kp1KOqx1ThFrBiJ2ugKuXuyOCyu50ec6gHDlKhhjYj3Ac3r7rMTFBCBFKnHcueJUin1Uqj8Lkzbl
30Rl7EBeiQQCr3/nRuPQDIC2Zug+G2OeZDIGHOUdeEqDpLLFewwMEF+rzpKDg7MLxMcf10mRF9Mp
5xyKONKdFA45OiWioxbscLy24sJGwn1VE2NwrlGCNMxVrENFhzOZUX0z8Uc7FYUKcqRvE5yr+lNw
XIL9WcNWSMCmA9MB8nJ2GY2yIk5IUZtDp7liw+s25FYNbenYSkZXZDGJu2huFn1Kb5NsiG2X4JLS
q0JhFuWjBCbriIGiNUPkiJaoTpg2XVijFxkmEykkMUJA7IKDmQRMVTMtUlACXDg2bi15QQawYvGf
taHRucK7BK8SyxZ2zaINFmcdOGm0oPS19fCLZwHjC8VZAEuajeuEpkYEkZmEQ6d/Cay9FKAret9g
1jah91XmcokcChMlA441qvWLZi5ijCZwTkU4PQQdDCMBTc5SBJHCjtNBEV2Y58M+AHer1CxwGUqh
MYLuRWohokIlZJlp/4u5IpwoSHEXcayA

--=-yHUguVYJujXSrSqPD7ta
Content-Type: application/x-bzip; name=11-opt-profile.bz2
Content-Disposition: attachment; filename=11-opt-profile.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWU6QmNoAA4/fgAIwaX///2/v3lq//9//UAV7WbJ4JjFAFKUholNNAaAGRkAAGQAA
NABoAEqnhFNoKZpANGk/VN6gTCMAAJkYjAIEiKaamTQTU0yGmmgMjT1AAaMjQyNPKADgGEYTTEMA
gGQAwjTJkwjAQ0EigjUwjFPRqYk1GEAbI1Gh6jNTI9IDanqPUzafJkweYbbqb5ycQ5wrFVLq2McK
SWiEbyX7NTUTOR1SR8teaGJVjGBRSjymjwRexKXoGEBKhIyIxtO/QSqUioMYOXWubPQoNt2vk3Yv
bx5NpBBPkTH0kiICDAJNsWkCcEOgRqigEN/DcMNz2HMfhMAzMngqMssm01NSSVCgXFYFKBTHt9YB
Qny4XBIWM+oR0SriXYMmukvlqYyhCoz2LBIjf3Iji+logzxGhegQR34OBxt/Bu5LLXoh48GWDZML
gJzElUMazQrNxNXBIsJRYVXCQayVBpNIHoGJaGlnTUjL/TLbXLBQ3j83GEP2qwp/zUOFhWXiAk+l
EcksyoIIpb46qyPuyfhjCjs4/Eg5RNWOXQKRmb58lndKYx3S0p5AmepGSSPEgOYbGQEMFod2Wzo6
MNhPHjVHUNh1B2Zeh9J0vBBiLzhA51qCRwAdjU+wFECJFBZb6RgMC8DHnzx+iHFFqPy/zB4fIOLg
O4I9IMO2rajKt+YajyA/bAInu8gTDgGHnaOaXN6SoK4FTjbKRMpZQrAYRClB0n8OIGADD1nPjreC
14TAXwlNOJJItZMk9t8egwARi0ZlWiaedLXWlXK8iD1FEqgHgNJSqkqTSuw3GP3a2G8m4hVtx3XN
lihu6Au4lupL5+yBwoPcLiIPeCYvCLj5+U1HRk58QYWkI1jNPHzfc5teY6qCTluhF4leYzWWI1yK
UPpZyDKaEIwFBZYyVaJTVXQUPGfCouQ0X+obhIAvQ9wyWpKo9sAJKpK3IAyFAyRkaplMBjheTMIl
bR2xn6/L4/RbymJiYIJYXETEqXcyXCUCcDfWXawfXpL2AdoxfV2Zs97iwCSNE7xamKhWUqUGiSKS
nwqiwMS0qqt+Mj2XD72I6FZS0Dy5fjksBHWskv1Ag+qKCG0CB+hELft785k1QRsLlcJmzXBbkq0K
pJpGuhIWoYYrvFIOouOQwyOU5RQrQNQGBECANJGbV9RUlNBFIgiyaYavCNwFDUuCM5G1TLQqWtZA
VDDkXIAGcVIQzMRJICYp7ETWKTSkkbtBF68CsS52X2a0qnxQ1ehFQ6gNA0TPvVEmZJAchYaqxbQm
LRXzJe6Jc+Z/GgrSDWULzQYhts2Vs3rEgBG8NWiNnKCC1O1Vgc6oFQb5JUuEWrMCwtRwbWtFPftA
oYh0V49tXEwS23KQyQhBqSsRYlKUWJQQptJZmUwvJwEAeAkUOCLUsDaluNhr1hcaFHvzcRcZEJfy
JNb4m4I9arXdEmxUBiqA5djSi4ZDgjfGlsJLaQZdkgyAblLlkLxWh5iiyBo5YiQEFYaAWhxVQxRa
8WkcN92V5UYK3ilughYkzC0ZqMD4hwrsKFzkqEk7c5UKFLUCgV40ahzsMiDZWVBhas8kgXpoglSh
qC65tMYrMxiMYJZCPmESDEqrCGYcDmvSU6mNtbmM3QG2Rga+RJNGtFglhMxGKD+pokmC7/i7kinC
hIJ0hMbQ

--=-yHUguVYJujXSrSqPD7ta
Content-Type: application/x-bzip; name=15-uhci-pci.bz2
Content-Disposition: attachment; filename=15-uhci-pci.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWeCvWD4AAB9fgAAwQW/+/kAAAAC/5d8AMADNoGqbSD0gABoANAA1T0agaAA0AaAA
EqaTJpM9TKNAeoAaNMIQwBB5TYNZCwJjIIUGsxUmY1sgrdYDj4xRT1ODNMtQj5jVEg4UTtgXXj0v
MjI1D/NdV5EjARjnuSgnQxDYxDzkxGkn2lJUEhDAepwi1Gzc4YcgyBLsXX408mjJkzMKUT4ZBiYl
nolFRyDQiQKvB3NGWCsHGYumM7Qey0aki4gLKuTGrgiKFLywafheAgjR4bDRZUCMgH8XckU4UJDg
r1g+

--=-yHUguVYJujXSrSqPD7ta
Content-Type: application/x-bzip; name=20-e100-irq.bz2
Content-Disposition: attachment; filename=20-e100-irq.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYhPeXAAAE5fgAYwQG//+0AAAAC/7//CMAFUmASSKMjTT1A02oADQ0BoAlNIJpTI
xMAmATAAASSRlNpNMnpIwmCekA2iMeqRLKD6QiQ4JCoZFixTeaaS9p1STyQoVO1gAYNpozkMt5P6
t5WlQo1qQ7waLuSzL1YrK2VIHylPczhoE0VLGpo8HyIoGlOIylJwnFVNqOleMyFoaZuH20NkWNEi
4Oi1BJi8zVUqpR79ard1CtbS/EhSRZwORj/M4I+x2nQwaCeGtoK672445ZAlpcWhSEYCctyhPcyc
T9AwfyWWmA45VvXCPMoqT8Ar9T9SMxUGg8JueJObiylhphNlGgxT0Yl4tKy9xZwqIwSHK2hHdNCw
IRPLqHmsgUEBnplpUbxlZJEmcyuruLbDwRWYCDARWckqwLREAlkKUbGZ4wwahgwuThPJxqC//F3J
FOFCQiE95cA=

--=-yHUguVYJujXSrSqPD7ta
Content-Type: application/x-bzip; name=30-1Gb-lowmem.bz2
Content-Disposition: attachment; filename=30-1Gb-lowmem.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWTRoomYAAXVfgAowWP//+vvv3+C//9/gUAMg8AXdV2wNERpoyEGmjJMjTAmj1NNA
BtI0yZNMQZUaYmSaQeCjeom0mg9QyNAxMjAjRiAyJoJNMp+o0RkNAAAAAaADQaDmmRkMmCGjCYI0
0aMQNMmRgACCSTU00CFPGlPFGNQDT1H6phqeoek00NqPU2mkKgLNfMCIAKBaKQaYDMGL+Nct4+Sn
pPWlCUfttO6Pfp1I8RPuOFtSIzvQrmCGO0C1GoONuEJzG0WUABtQro6xiy5hVAs0CgV0is5ErJiw
W3+bnlF3VxdUb2yH+gDiohESSC5IX57HDfwuvOwNYMYThGTyM5A7huE8HGTKHI54Q8mSrgCGOMUy
eaVLGLrx8WhhqPqBSAyMWDQZGa2Au8d2cfIz1hmAqDQhVjIGGICbSbCF8ZhjYEdIcgoZE4skLSm7
YWC9gpKByhUEywzEV6U7kyuEQYA2B19Y1xEIhkDiDKH1eF9HuHCZ/iNrvVE4uApegIlKMprHoIE3
glMYAYMeYlAxFJXncTC5mONqSctw1BWAxwthJXwsFVoPMYxqhtHnPuBqCBeMZuSY4kPWOhiBuG7+
popb0t4wtopC3m4VOGoXcGZMMSiqAbuCghhOdd5UaihXIkakpzGQRwsYZcfLIwDK6wziycw6eLJV
mVDFosSIpxMaykzj0WKFSHRaMigV+CLw3giSD+Hbt29Xb/qS9viDLvJK1h1fSSNpoJtOh/WNbFWh
2CuWkNjBfexBYDlLKccRXOmChUoMzbH0CggS+QULGRmwNhqwo96uP2UoqdCGhL4USIURmUT1yghw
WFuET0bkiEcmojgKnnUOMwVBUBUCFAt4BT3jEl9TX8oK3YKmD2UItnQeEiYuBaOVwZMwqBoZFUgF
YYYEPwhsElAUuDpyBNNXA5w4qJMMIERfLPsKNVEVaVBxMxD0DG2ZYg6Ti8pInE4xzvWpqGSxLkwT
hQaYGCUGzYhSLRNsNpJYesWA8p3i3mM4YTKTxoEjBSDMAoPcT6liR5QgIS9QjBMKStTrLWB4FMAX
IsdBEjlaDowAZpd1BChoXMDzCTnzFuk1sOXILUBvhDdRP60X3Cdem++yC6KKbxLx6gIHTsCJdsYN
P/F3JFOFCQNGiiZg

--=-yHUguVYJujXSrSqPD7ta--

