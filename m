Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311445AbSDAMYk>; Mon, 1 Apr 2002 07:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDAMYc>; Mon, 1 Apr 2002 07:24:32 -0500
Received: from postman.arcor-online.net ([151.189.0.87]:24586 "EHLO
	postman.arcor-online.net") by vger.kernel.org with ESMTP
	id <S311445AbSDAMY0>; Mon, 1 Apr 2002 07:24:26 -0500
Date: Mon, 1 Apr 2002 14:15:50 +0200
From: Stefan Frank <sfr@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1X>: Possible SMP<->Networking kernel bug ?
Message-ID: <20020401121550.GA14359@asterix>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

since some time i have a problem with my SMP system ('obelix').
The symptom is that i cannot transfer big files onto this system
(the server). It doesn't matter wether i use scp,ftp or nfs (knfsd)
. With NFS i receive an error message "file too big" as soon as i copy 
files about 2MB large. Either scp or ftp (upload always) will simply get
stuck sooner or later. The maximum i succeeded was to copy about 230MB 
out of an 680MB divx movie. But it also stopped at ~50MB once. Please
note that there are no further error messages in the log files.
I have attached the tcpdump output of such a failed scp attempt.

This has been happening since some time now, and finally i started looking
into it. So i compiled a released 2.4.18 kernel (without any additional patches)
with different options.

The result is that when i disable SMP this Problem is gone!
No more NFS error messages copying a 680MB divx movie. Also neither ftp nor
scp got stuck once. This leads me to believe that it might be some
strange issue with my hardware and SMP or a kernel issue.

Here's more about this SMP server: (dmesg output is attached)

	- Asus CUV4X-D motherboard with latest bios 1014
	- 2x PIII-Coppermine/866 MHz
	- 2x 512 MB PC133 RAM
	- Compaq NC3134 Dual-NIC (using the eepro100 driver)
	  but same problem when using a no-name 100MBit card 
	  with the 8139too driver

The output of ver_linux (Kernel compiled on another machine!):

sfr@obelix:~$ ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
 Linux obelix 2.4.18-o1 #1 SMP Son Mär 31 19:13:52 CEST 2002 i686
 unknown
  
  /usr/local/bin/ver_linux: gcc: command not found
  Gnu C                 
  Gnu make               3.79.1
  util-linux             2.11n
  mount                  2.11n
  modutils               2.4.15
  e2fsprogs              1.27
  pcmcia-cs              3.1.28
  PPP                    2.4.1
  Linux C Library        2.2.5
  Dynamic linker (ldd)   2.2.5
  Procps                 2.0.7
  Net-tools              1.60
  Console-tools          0.2.3
  Sh-utils               2.0.11
  Modules Loaded         ipt_state ipt_REJECT ipt_REDIRECT
  ipt_MASQUERADE ipt_unclean ipt_LOG ipt_limit ipt_TOS iptable_filter
  iptable_nat ip_conntrack iptable_mangle ip_tables ppp_async
  ppp_generic slhc ide-probe-mod ide-mod ospm_processor ospm_button
  ospm_system ospm_busmgr rtc

Used compiler:

sfr@asterix:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)


I'd be happy to do additional test. 

Happy Easter, Stefan

-- 
Your lucky number has been disconnected.

--AhhlLboLdkugWU4S
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.txt.gz"
Content-Transfer-Encoding: base64

H4sICLckqDwAA2RtZXNnLnR4dADtWntv28aW/5+f4gC9iyvhSjSHDz24TVBZdhK1ka21FLdF
URgUObR4LZG6JGVb+bz7QfZ3ZkhZdpzEanOBYndlmKKGv/OYmTPnMZz3Sbq5p1uZF0mWkm26
pui1M0GNPMvKH4KilHly36TGdRjuofqe6ZJtWUJYlk2NEzlPgpTWuczlUgaFbDbpO0HT8YSm
wI//OydHkOj7wvE9m4an0xlT28bx6HzaXufZbRLJiNaLbZGEwZIuBmNaBWvfIAWQPdvyyXry
ofZ+Uz8O0dTYFMF8KZufI9SoR4SB4tXIZSHzWxl9ljT+RKawXkYqnqrrxDHr8RV1d6jHhLEi
HAwnI4qCMvg8bfyY1q2HTdOeXU6fJ41l+FRfbhIv6Gos5aek8mWkWt89UlE/2if9OcjTJL2m
LF1uqdfvjI/pLlkuaS5pU8jIND4UkgJ6N3r7bnw6Jpny8EZ0I/NULk0jzjZppMxyPGmX/IyC
kgXGnhtZxmLVonVwLXULi64lU3mXhNJ8jOh8FfEHeZynlGYRAFRmZbBkcOGTbfedbsf4mKWy
YTV9cq1+RzEqTN0omgzy7J71qNlG865llJZySePNskwmeRbKoshymq5lmMRYeSWv7lthugbh
c5nk5Qar8ecklxRmqzWez5NlUm5pBfWgJ4Z4dOITvvVMgWW0CUvVOLk4P9lN4WAyGmKoocj9
m9NT1WY8yP/OoYlMy2SzapSrJnPRBLW/Ed19sPVV8OjoXLd9Z9PlrllNNcQPlXjzgSWPrfGT
MhHu5iqAjSyTVPoUbMqMjs/PZ1ej8eDt6avbFdo3Hwky2T2+6sH5pavk6i4ow0WUXb8SYJAW
2VK+Ksvt1Gr1Mb9pb7/RwhQkZRIsk49syMPJh+8s40SWMixhAL2uZXq9Lo3ffYQ3rfQzjaGm
98FomW1yunw7+Af1rHvbM4bgNM8xM2AWyWWwpWWWrU3TRI+djtm16Di7zsajydQYy1WWb33q
W5YnOjdHfdH1LPeGgtsgWarF0BC21buplguERbJFooM+3OxstEWuEDfK9bTIBhtK0J8WAbJI
rhcruWqiO2mZb9thEC4kLYJiQXqtcXPCpiwcYXURN7I8krlPPUix3J7X7dB8W8qiiTGC7C8w
6Hie09nRd1vk2a7d69XkY6zz8kvyO07P3ZF7rVqhivx4E8cyf7H4DgaiYwvXreknWGtfoK7A
n+89jMKnYxlnWHe3Mo1g9XqQw2ANesvpOfE8jnfOc3fTquGvyNJc3gsakVKFe/1TixtO9hoq
lF032V7dNogR+g8Tv7up3MwKPLGOCJxDmFmOX2znG3Sr2KzXWV6yy34Om0t+yjZdu3AsYbVW
TK0df7SG1zJFihIeot2OQ/0ZYtVDwMs5nLJWrF6MDIneTD5QEdwimMBzYKGUmDhegRHcr/mA
3aSroLhBX6aj8YkikvehXCunW43HA9WQx4Gp/r5Yln/HBBRlDtcKLGPOf4L/Op+OfmHXAjuB
zwolwXjUmM239OFs9Gb0i7Eqc1gYe3SEUc7XLMfuNukiCRdBHtHbLAsXiK/X/P1DUKaxGRZJ
npnBplnRRrVr4p9UbtcwEjVj/0ut9K9ueeBgVTNQx0EajUbUGGbrtcxX6EmTkLWv19wHyzHQ
2AYRlclKFkvkFxQiqsUx3KYjTDgdJE4hMoO6u6f35ehstuu1cTq9oNtguZFIstRcy9qeb2EY
We7vrYodNFAD9HnkMaInP9jFOBJHFslkzWXBMyFSGNXSeayd+Pdod0BM/T+2CMRfZhGIgxbB
jPNoymKyH0yuoAD+9DZg59Zw3K7DTrKe2Cb89tng+P3o7C2Nztsqmxxd/FdhTGWpBsbGQFOJ
CM9F61USXa05Q0rLK9StBkwFDja9ZmBNvStuNa8T5PZgwkaV3ZgGzxqgVw+CdoSNYJ2ESdRG
X5pkt2E5dlvoq1BXW10ddfX4aquntnpqq6e2g4qi5GCRKm9uQsXZaHx64VfW/8q6R4UOEeKV
zV/2K8uohoc7cTYe0c9VkksPQaoOOPz4bv8xx6d0s5rDQDDoqLfQJSqQuoYq/eruP637iWQ9
l9cJ7zhwkuQ+sOdhHumU3nz+YxijXcpftfBlxxBVAxebdmU/FRXbnv9kYpKIcZ9QC3YPotuz
hNinBvkquAcwQo2kovNDmsf4J9gJRiFZrZdyBZSEpKfM6l5UxYxiIj5Rxt7zVY/pg3yelLmq
4xijKXns9zVU6ahv0NkFvcd8TRZbGsO70ixPYK4XFzTJljQtUS6dYAJwWSYoo8KSF61Beh3y
FwkWatUXa/9HdbGAF/hysAifPt3hxe7i9IG3D8ALg4EvxruMdw/Asz7ey/Ee8+8cgGf+3Zfj
O8y/dwCe+fdfju8y/+DA+Z0fiA8PxEcH4uUB/eXxiQ/jL6wd/wdGVnXzhH8P4ynEAXjoI+yX
4/vM3zkAz/zdA/vrHYjvHIjvHoRnZ4bIiRDFO8Qc3wufGy1qvybLt/le6HvB946+d/je1fcu
33v63uP7jr7v8H1X33f5vqfve3zf1/d9xb9iJBQnUZELRS8qBkJxEBULoXiIiono1277i58q
yH4oOAYus12I4kye8zwEg3yzLpG7h3sJ6x6kDoMm524UgsUNFWuJfCcpqq0mzO743ccatsjg
7+eb4ilWOI7Zd7wKG643CC4tDVK7OQ4/bJEqL3xy3Y4LT8iVyvcz9JYfu25rJvxe3+71rNYJ
2lpTX+NaQ79i8FpzFi/hLJ5w5ieOzZyt5znX5fRsOqRim4aLPEuTj3rHMwjzrCh4kCBzHRRq
J/nnICn1VjNSm6S84gwNeR7vksHwOG2/t5vGYLnczygXvAvA00Y7uDEZjhD5hyO17Y1AfJtU
L1HgSdRGmd6YjK2I87ZloKfgla0J9exzlZ9cb3RkV1U4UgfNOM/mjGABXNPfBbk0PqQ3aXaX
0jxPomvJWxIq9YLpEXq3WamkKg/SYg10Wn4WLw7E298Iv9dzlbxkG058LkcD+k0Iq3NkdXqd
3/XWvW+5psUE7dd17qxZ8a6IT41jqzVyWxOnyUsPy/BbIZF7TywN7X4Nau+gna9BnR20/yWo
rVR9IdJ7LN6n3Y7UZRKQvMfYprVv4aHGE43jx8wwTu43awLHarxRUsR5tuJQxUXMl8HOE/B7
9cLx7HSGeVMw3WCbrnEcYOXRZg0Tn96hDzKgD2micuFyy1XiWtnBNAsTiQbwcEwLOeOj7YKL
GaWyRPfgv+BFZGkgldXF7E1xF6wj40cYHzrMZe2x8nMnWJOwxihnWfC0QSQjg9+S+RCKwn66
mRdb5N6r3UuG3/S7T9H7vcI9QKqK2ViXW1Wjcxfu+z3C72K3jvF8irIZo14JrRl7puWFequu
bXXbVq9Jd0m5oPHg7NeryfnFbErTd4OL0yse6unpxWjw/oqXfnWrXu3VGqhXEJb2LpYT96iR
5P+C43Kb7NMDmIPnWQMNExXMfoA5j2HTLC7ZuTzUgTMOMogEULlVRZxVkKPo9aljUSFDY87D
Czdu9+DBs7IgFOf0r43cyBbNmc0rxzakhAMVlmWG/q0wrf4/2yX1j+z+Ub9PJxkmCtME5w3K
RVmu/aOju7s7swi3y8gMs9URJvsuy2+OdmwW5Wq5z5T+dlH5XGhiOh36m9pkOhLiCMF6nEVJ
nMAU5lsapFEut3Rp0jS4zcIFAgZ9XwR3P+DfLO5YnFlcv1bbvBmK0rwwZLmw1AswSnq253WP
1FcPWeIRpNMpo6BhSy0G2x94fsfyhx4SgpZaLaJvGkTHGe/GcuBZzZdblEyW53lt2ECLqzNd
nVa1O0eZaqvBp4sfXQ/kkzzBwG91ShAHvMW3SNZaI48m734l3rghest7NWBVyGXc5uL6IdoR
VfZYbObtypKfhfGmi3IXu1r9edzF+VhvJsG9f4qgBmzNjRGke/OmyaMo/tAo9qtR7Pz/KJrG
dDgdseRKcOVZ9o0f+XOxXZmWKXDvg6Hey4IDuRqej+FjTq4mg4vR7FfOHIEE5vte33vNWQu8
g+BkaB0mKkW0KNJuEwVOvEn11oJF7DsQETXxTN7kwYrOLi8G4xbveXVb9AYJTttFpvP+8oRf
hOfs2+v0rKJTPTn+MOXXZzSXMlWvH0voFBaJRdB8u2ojgTJFN8AoXaqdT59Gx2PSH6xqufTp
5Ox02nasvuha1QOMBtgP3qHwoJl6mUF0onZG2oOQszh69jM4g0JKq3w3nJbzRdGTaS36bF90
3zn9xqKnp4O3g9npg+jpzOnbonP2wEOJ5rc/31j07Hz6bnQ8eBA9PGmzyf4ybnuuJWaDSrTT
sbw90RXqS59nRdvaPPiPyuD6Giugfl/PQWVvv7r16AFCu1wjiLKbUBzEn+Zg/xkOg7LkLfyI
2JwpSgqkKlHAEVjZNwgXQcpv4HGbRHxdbrC2nqebf5ZOfJEu/CydXdNVo01vBtNZ27b0fNiI
9zQ+PipgZ9Tw+FdatCiLY6xQckRT+6HKOaBfvN/bFx3btcgTdpvfcdMiuss5Q1COuIFF4oAl
vzhHoqYciXIIvqHpcRF8sfni0Pf85fGlQ6/5y61nVWsKQT+PTk61ur1H6tre19SdH6CuhuPC
2s1Zu7nDF1epOPfodW0sf24IQ6WTa3s99/M68akRrVPIOoXC4Bzbr9Lr2XByNJpwCFA5t06/
DbSgfiyzMFui8h0Nx5MWfTjBBXD467fjCSB+XRTQJ0casph6om8jHnCijS503J/UGQYDDHx6
t0PuZ77UQAjjAqRgk6xPTiRYJ+pYRbPSm9NmlNKrAEmYTuQLVv+IT289lA26I6Zx80+d1MPG
q2zf1O+VklIH9FsEW4/HK0ujwjj9Zea0Y/R5xSdFoEacQEkdN1W+rc5moJ3PuVSnnS7fTH0a
V3g+/oOO3JfOHmkTziqI+GyaabzJpdQv/flgWn2kZlUdwVEHZ2JAUGdEEeNQ8KzhKF3R79tY
nvjVRjWM6W+s8yRTQbINw2DF6c2Uy6W2ZfYRAPn0CP0YpOpAJQfoImr0WnazpfvNSUY1NsaF
xA/O2mmo656q9kActWRdyOhBiJN8pbL96mACTBXGK2jq0tSroJPsDtTHm7KE1MabN01S5+uq
p+qM2RpGslawuYIVu/MEUO86Rb/4DEVyL6N2LAM+GfIs7+G45r07tPWb9TvCjUVDsdcmdm1/
wB5eMqyd54b1jxjTv0k/0f2LK+j+xfUTvW+lIPwX78HoddCeLINS/Txtc2j6JDfvmI4wkgjp
0aDeEHMcPgVYSeGMW2/Hsu+bjM6VlOI/KQOfHIRaD9zw3uH9vXE5uYIgOHVIwxCUebZc8vvW
VO0UqgReZfBwRU82haqwo3dvBGoM3p7nfWskkM0dX66NOFrt9jM7u0f8phll239QGpToptLU
1+d0UZTPJdcIBWFAZP5AIxMu8pS67G92Bw8avGvaNP4HDS1B9acuAAA=

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="scp-tcpdump.gz"
Content-Transfer-Encoding: quoted-printable

=1F=8B=08=08U=D7=A5<=00=03t2.log=00=C5=9B]k\7=10=86=EF=FB+=CE=A5=03a=D1hF=
=D2h)=B9*=BD=F6}=E9=85=DB=9A=D64_=D4=86=06J=FF{5=AFj=F0.=E9=FAx$=B9=81=98=
=80=93=CD=B3=CF;g=CEh=F6=98=E8H=E5=C8t=A0=C8)=F2vs=FFp=FB=C7=DD=97=C3=AF7=
=EF=DF=DF=DD~<=FCr{=E0XJ=DC=DEm=9F~=BA}=7F=FA=9D=FB=FB=DF=8E=DB=F5FLZB=8AG=
=FB=83r=08W=14E=DFl7?=FF=BEq=ACT=B6?=EF>n5e=DD=BE=FD=F8=E9=F3[=FB=FDp=F7=E1=
=F6=FE=E1=E6=C3=E7-V	=BA=E5=C0I=C2=BB=ED=EA=BB=EF=DFl?<|=BA=DF=C2=17=FDq=FB=
=86=9E=F0UN_=87hp=FF=C5}=DC=0E=E0xd=04J=E6B=F1k,=9D=A2#]d=11=8A=C9=E1=EA=B0=
=3D*=82=ABZD=AFH=16=B8=12bO=96=9D=CF=B0=8C=AF=12=D5=BC=88/=D1X=96=C68+=CB=
=14=D5[=F7P=04WQD=D6=D4=BD=14=0D=DE,=81=05>=D6=1A=17eY=D4=E3=AF=F3=19=16=F8=
=12KX=C4=A7=85Gj=0D=0Eg=D5=9Ajq=D7=9A)=82=AB=9CT=D7=D4Z=8A=A5=0E=B92=C6I=AE=
=92=14q=D7=95)=82+=0D=BC=A8=87%Qw=8F=05=16=F8=AA=A8,=E2=D3 =8E,=AF;=C3=B1}=
=CD=E9=EA=91=EB=D1=E9=ACl=95=AA=FB:0e=CD]=0C=A1p<=BD=0Er=9A=E4=AEj=1C=BA=0E=
=8Cq=92=AB=DC&=1Fg=9DuEp=15I=CF=FA=EB,W=B9=DD=01=DC|=86=05>=CEQ=17=F15=C0=
=81,;=E3=8E,iO=96=99=BD=B3FW=04W=ED=8E=96_\=F7=F5_=CA=CB|=95=FDY=1A=16=F82G=
yq=96;=F9$=BB=F9=0C=0B|=A5=FD=E5U|U=87j=CD=1CN=AA=B5=12=C8sF=E9=B5f=8A=E0=
=AA=86=18=D6=D4Z=B1=B1j=C4=951=EEvU/=B3d&w]=99"sEA=F2=CB{=D8>WY=BCg=80=8E=
=05=BEv\=C9k=F8=B4)=18=C9=12=8C=93=B2l=A3=95w=8F=D1=15=C1=15S=965u=AFQ=DD=
=3D=0CX=E0=93L=8Bz=98=C6=EA=DDmt,=F0=E5=90_>o=EC=E3=E32=D4c=E1pV=ADq=F5=D7=
=9A)=82=AB=C2A=17=D5Z=A9#slg=9C=E5=AA=BA=F7=18]=11\iI=ABzXu=EF1:=96=F1=B5i1=
,=9A}*G=CF=1E=E3=BA3=1C=99=03=F1=93=F3\w:)=DB=CA=AE=B9=11=D7=01=94=C1=1DI:9=
=CF=19=F1$w=A2#=FB=C6=CE8=CBUq=9D=01PgP=04W=B1=86=93=FE:=D1U=F1=9F=E7=80=05=
>=E1=D3=DD=F64=BE=F6BT=86=B24=C69Y=DA=9B=F2=CC=8D=BD=EEM=11\=A5T=F3=92=BA=
=E7 =AE=3DK=CF=D2=B0=C0W=82=C8=A2,=C5=B5{=EF|=86=05>=95=D3=DD=F6L=BE:=B2;=
=EE=0Eg=D5Z
=9E=B9=B1=D7=9A)=82=ABvu=87E=B5Vidw=DC=19'=B9=A2=F6=CB]W=A6=C8\=B5W=D1E=3D=
=AC=E1=B9=AFK`=81/=E6=D3=DD=F6D>=AB=B5=81,=C18+=CB=14=3Ds#=EA=1E=8A=E0=8AUe=
M=DDS;=9C=BB=B34,=F0%=E6E=3D=8C=0C=C3=CBgX=E0=CBE=D7=CC=1BL=9A=87=EE=E7p8=
=AB=D6T=3D=AEz=AD=99"=B8=D2=10uM=AD=C5V=CFC=AE=8Cq=92=AB(=C9=DF=C3L=11\U)=
=8BzX=B4=95=92=97=CF=B0=8C=AF=FD_q=D1=EC=13K=F5=EC=CC=AE;=83=9D=E72=3D=3D=
=CF=C1=E9=ACl5=B8=F7=1AP=06w=ED=88yv=9E=CB4=C9=9D=9D=AA=07=AE=030Nr=D5=1A=
=AC=BB=BFB=11\q=8Eg=FDu=96+&=FF=DE=05X=E0k=03=81.=E2K=89=86=B24=C6YY&=D7=BD=
=BC=D7=BD)=82=AB=CC=94=D7=D4=3Dku=F74`=81=AF=94,=8B=B2=ACq,Kc=9C=95=E5=C0g=
=99P=04W=ED=0D=C5U=AE=92{=D6=00=96=F1=A5 9=AC=A95=E1=B1=CF2=C18)=CB=F6&=BD=
=CF=DAtEpE5,=EAa=F6=B1=87=9B=CF=B0=C0g=EDg=11_=1D=DBc=80qR=96)=F8=F7=18P=04=
W-SYS=F7)&w=8F=05=16=F8rH=8B=FAF=8A=D9=DD=D7=80=05=BE=92=CE=F7=C7=D3=F8Z=C2=
C=B5f=0Eg=D5=1Ag=F73=10P=04W=8A=E7=B4=97=D4ZICg_0=CErU=93{g=06E=E6*=87=B3g=
=C6'=BA=AA=FE=F3&=B0=C0G=F9|=97=3D=8B=AF=8D.=9E=D9=E7=BA3=B4=F3=1C=85=FA=F4=
<=07=A7;=B2=8D;=B2=B5G=9F=BC=D7=01=94=C1]=C43=E4O=AE=83F=BC=D7]=BC=CC'ih=DF=
=88|w=B9=E2 =CC=97Yr=1A=DAcOe)=EE=9F=E3=E8q!79{=B6~On=14v=E5V=C4=3D=F7=00=
=0B|=A9=9C=ED=D9=A7=F1=15r=3D=03=BD$=CB=12=E3P=AF=9F=CA"=FE=CFG=10=17r+=F1=
=EC=F3=87y=B9=95=A1=E7=AF'=BA=B2=D1=9E=DD{=BA=AF=F5=F5=9Dl=99w=B1=89=EF=9E=
=B8;/=0E=FF=D2=BC}=FC=F6=BD=FD[|=A1=ED=AF'=EF=F1=EF=ED2*=87=D7h=AB;=B4=95=
=9C=89=9C?=1A1=12i=9B=BDw=B1=B1o]=B7;=D2=F62=9Df,=D2b=0F=B3=BF=C2]=FBym=F1`=
=8F=A9UOw=1D=8DT=EB=1E6+=B7=95=91=A66=3Du=9A=91H=81=CAC?,7M=9B=1C=A2=A6Z=FE=
=87H=B5=9D=C8=9Eg=CB=BE%=C6=FEHK=1B=D8;=CDH=A4@=8D=FA
=91>=AF=AD=1C=DA=94_=C3=EBG*T=9F=BB)t6=F6=3D=F7=BC/R=0E=F6(m=A7=19=89=D4P[=
=B3[?=1E]=D2=F6=0F=EF=08=B7#7@=00=00
--AhhlLboLdkugWU4S--
