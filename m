Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRDJTQh>; Tue, 10 Apr 2001 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDJTQ1>; Tue, 10 Apr 2001 15:16:27 -0400
Received: from pua.physik.fu-berlin.de ([160.45.33.106]:9231 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S131878AbRDJTQK>; Tue, 10 Apr 2001 15:16:10 -0400
Date: Tue, 10 Apr 2001 21:16:05 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, "Manuel A. McLure" <mmt@unify.com>,
        Jens Dreger <Jens.Dreger@physik.fu-berlin.de>,
        David Hansen <David.Hansen@physik.fu-berlin.de>
Subject: Re: Still IRQ routing problems with VIA
Message-ID: <20010410211605.A1052@pua.domain>
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A1@pcmailsrv1.sac.unify.com> <Pine.LNX.3.96.1010410125456.26863A-100000@mandrakesoft.mandrakesoft.com> <419E5D46960FD211A2D5006008CAC79902E5C1A0@pcmailsrv1.sac.unify.com> <20010410193125.A31792@pua.domain> <3AD34518.2A43A346@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD34518.2A43A346@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Apr 10, 2001 at 01:38:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2001 at 01:38:32PM -0400, Jeff Garzik wrote:
> Axel Thimm wrote:
> > 0.7.[2,3] are the usb devices. BIOS (and 2.2 kernels) had them at IRQ 5.
> > 2.4 somehow picks the irq of the ethernet adapter, iqr 11, instead.
> > At least usb is then unusable.
> > As you say that you have the same board, what is the output of dump_pirq -
> > are your link values in the set of {1,2,3,5} or are they continuous 1-4? 
> > Maybe you are lucky - or better say, I am having bad luck :(
> Changing '#undef DEBUG' to '#define DEBUG 1' in arch/i386/kernel/pci-i386.h
> is also very helpful.  Can you guys do so, and post the 'dmesg -s 16384'
> results to lkml?  This includes the same information as dump_pirq, as well
> as some additional information.

OK, gzip-attached to this mail.

> Note that turning "Plug-n-Play OS" off in BIOS setup typically fixes many
> interrupt routing problems -- but Linux 2.4 should now have support for PNP
> OS:Yes.  Clearly there appear to be problems with that support on some Via
> hardware.

I had the problems with both settings (but I have tried so many patches and
kernels, that I cannot be sure about the combinations).

> Note that you should have "Plug-n-Play OS: Yes" when generated the
> requested 'dmesg' output.
O.K.

On Tue, Apr 10, 2001 at 01:01:07PM -0500, Jeff Garzik wrote:
> On Tue, 10 Apr 2001, Manuel A. McLure wrote:
> > This may be the difference - I always set "Plug-n-Play OS: No" on all my
> > machines. Linux works fine and it doesn't seem to hurt Windows 98 any.
> 
> Correct, it's perfectly fine to do that on all machines (not just Via).
> Users should also set "PNP OS: No" for Linux 2.2...
> 
> Other BIOS settings to verify:
> Assign IRQ to VGA: no (optional, but you probably don't need a VGA IRQ)
left to yes then, to keep the same BIOS settings/errors.
> Operating System: other (or Unix, depending on the BIOS)
n/a
> Memory hole: no
O.K.

> Unless you are using ISA cards, make sure all your PCI plug-n-play
> IRQ settings are set to "PCI/PnP" not "ISA/ICU".
O.K.

> hmmm, maybe I should write a Linux kernel BIOS guide/FAQ...

Yes, please!

And here are my FAQs with what I think are the answers (which means they are
possibly wrong, but then you get the idea, what some ppl might misunderstand):

Q) What does Plug-and-Play BIOS setting do?
A) It allows the OS to reassign IRQ/ports to devices (?)

Q) When should I turn it on or off?
A) If your BIOS is doing the right thing for you it's safe to turn it
   off. If you trust your OS more, turn it on. (?)

Q) Which OSes should I trust? What about multiboot systems?
A) Linux > 2.4.x, M$ xxx, etc. (?)

Q) What bad thing might happen, if a non P&P OS has in the BIOS a P&P setting
   or vice versa?
A) ... (?)

Thanks, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de

--mYCpIKhGyMATD0i+
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="dmesg.2.4.3-puredebug.log.gz"
Content-Transfer-Encoding: base64

H4sICGFW0zoAA2RtZXNnLjIuNC4zLXB1cmVkZWJ1Zy5sb2cA7Vr7c9tIcv4df0Wn9pIjKySI
BwE+ctpaipJtnk2LMSXfXrlcKhAYkAhBAIcB9Ni/Pl8PAIryk/KuK7nEKpsaAv31TPf0dH8z
o1dRUt7RjchllCZk6X3d7mZlLqiVp2nxS1Z6ebRN9WxzL6OtHpbdlcjjKNED0abW2vcPoCOX
LAM/A9uk1hsR0AuvoFdK/0A32m36yaTlfEGXpaBJlpNpQH5s98eOS9Pz5SWjTe10drHsZnl6
EwVQofr1vZjeTOa087KxRkpADAEl44Mf6h4+GoU+HrVK6a1i0f4csJJ6BPSUrlYupMhvRPBZ
aPhRn6ZxDDTEz2Ooubfgq72aH1naaPuypZCyHwObTqk1mS5mFHiF93nsJzq1H7Cv3y7b2tL3
EjXBYZ7uyG+0hylPtdWn1X0hpP6xWDUDXxUL99pcx7HdI9T1jdFe7CKhJA0EGVSkhRdn3lrI
MWuyDO23NBEtoz2uAOqVXj008dA1+xjV4VMLT43mCYIyQ6BOFrMpVBPPrVCOMcx+v49WW3sp
8kTE5Ke7nZcEhOUjxuSVkD69uLi8ns0nz89PDpZenhIvvhPbcCuJZ7NX5ye9FZ71bnaAl791
D8RllKxjoc2SqIi8OPoNX2m6uPrJ0M5EIfwCo3NHI90dWjR/8RthbflCyjTXtWmayDTGYPw0
Tsuc3j6f/DsNjTvL0abQtMq9gpUFIvbuKU7TTNd1Mu2Ro49MOk3X6Xy2WGpzsUvz+zFZTn80
cLc9y7WMobEl78aLYo5IapnWyNzStvFDIDrkDkx3S020d8ix+lsVgx2y+E0EczoENZtovdmJ
XRvWJEV+3/U9fyNo48kNFUo7P454Nm1r4A6pleaByDFvUORamIQqBNraaYmpyb+AN1172N/j
+53DQGtrC8z3F8CV7Gc7n3H0Hd2304GbTWNgNXDM55hOBaJaIOMmAaK7cpDvZUAb5tAOR2FI
vukPVKNZp51G/ISsSssrk2Y05YFgmP2X1HLrQfY4MNsdOqNqmJ94WWuwvoCvRCZhIfKnjXTf
ONSwFonII//J6CnWGorS8ajzBPPBwR56sqBniyuS3o0gXq+I0QJ+59gPsPyxbDbC37Lsnzdx
8WeYJ4u89AtUQZa5eKlri4vl7FcEeoIJw5r3BcE/ai2t7unq9ezZ7NcfU/q9pxQoFLHJ/IzO
yjxNWsWuTYsm+ZEsRJbxjIBzZEgLkKYi2gkZR5guH9k5DLEsh+A1DpVS+FxrUGZ2abER+Sr1
8gAVpUByrHKsTldSJctyt7uvyoHYlbGnwkJbikJNP9cAgXgITswOrdPqn7aYzsaq8NoWLZEP
eQRnUQ69SKxURRdnevAp445LoResjK+gVLKsEOHKsg7EuQKsUGUEdCYoDvIEXtvcnpgmk7kT
w9LBzOIT+EVB8FHBcnET1VQPAo/1O4jKmFfOqpQnNbDyBy+CaF3myhFU3GeCGsUYBktwBxu4
89bLRT3KUoLsSY6WRZQJDkL0/o8Sa4iCSLGcoJKcnZ3TypNwTRBgnUoKo7syU9XfMMbGQK/7
YpaQqOWNN+tNyooEe0wSRoVBk3GsoKldJdskvcW3PArWPDKJ4gnnI9o8Kcsdw4vcS2QGi5Ki
Humb/1Srpv6WwLi8zAp6k5YqMi5VPQjTEhlnP8/BKjA0NmRIMgYjMEx0Yli9QKyGZI4Nu2pZ
Y8OpWvbYMFVLoUY1ymKUvUc5e5S5R1kPKK9G2Yxy9ihzj7L2KPsB5deo/pNGGNQo50kjFDXK
fdIIwxo1eFJfZo0yGGXuUdYeZe9RzgNqcIgy9ijj86iDJcOhkiMsEP5vZxN6Z5qG2zPcofte
RYaKa+MhqlTIV18ncZz6FWlrolJWb940QRrU6bEb2KH6oVZ4YoKxdSg4wSrOTsBYH0NYfMSQ
ulFBDPMriH6D6JtHIoYNYngswm8QfngcwmvsQMM+DtHYgcbXEcHItEzlXm4c5V6WtBqIdTTE
biC2UUEspgZftKTxFhqDo2xfNd5aGUf4lwdjNKMyjg6tVePg1TGBEoya+B0Z+/j9qumrJrTQ
ONL0xlloHBcofuMsNI7rw28s948JLSXY2OGD/xwzIY2vTPMoXwVu4103PM67Qb9BOF/JJ8s0
r7eTiqrEkSzAlzXU8yzJPqi8iyQD08sDeSjxOqVFXK7p3/ALG9JajyqZWnXO9Pr8sq9Xm//q
AbbJ2in4QUBlhvq9vEVVFh5dJZE6tyrumVZmKtUuUz8SeAAdtm7YI21ZeNWAt/LWywK6MfWh
lhVqp+uyirvRkPBd7jkOWMkKCXg7JnCVkqmVImNMZu56cXqLXR5nxe1pz3H7rrs9xbbXtFSp
kAQSWsHALyLeN9C8jIuoC1sL9fW8y2wnyHno8H9FxkDYddvUogDUfdKQD9vmjb68B4PaKc4i
M4HRKMfOLkBhAyH/g1LoAYMRdBsVG0KDudvdnfZ2cY2OKm4Fy4o8jWP0CPcxU1NcyWDnE3zU
yPqbKJOieOCI7v4Vk2SE4b9SgsKELRX3PkafcVwT0Sj/hwR5xBxoi7OpZViuc0Tng6Gmil/N
9EIdH9T9GQbiqWF3mEBuiUtrh8SdH5MhLCWQiFv0iIXDX9YYHAPMup4+U/yreqJ010FWd6E1
pblhttgsFKB1lEFlvaX/ADXQnUr1JfZf0tsJpb2U9XwcSAZc1PcO+Mij1sHLp/h0E3hjmnt3
CERC9I2GV26HJpcTOpstX1bhBJnVXsZmmRf9T8j42ISddf+GkD0/Va8X2HWe9c7ennXfXMxr
McSRURFYM0SqwuegY9zZoctzyF4y+yxj1jIDJTNQMoMHGacaNrJd37awG20WUosHZ9H8tE23
PcvoD19Gp9XOtUPTF8uTPt72LMfpuXZl1O/UAJMrO23rVzae7eRfvTd/q+ztkMWHXrWK/dKd
HrjkcLHauol55LyitkM+nySMNVLG4sOkv/Avhz9c/hjQz/zL4g+b5VYst2I5frHiFytbexan
WXZfddeS7TGFgUER9ip6vz/Xnp1NSX31KMOGpmuORiYNLWMwwL40j7y4GWdzlu/oIOQtxUlM
q2va7SpFzCev/369uHhzuaTli8mb82uO5OX5m9nk1TWvztlysni9wM6w2qAVxf3SqGPBsMMh
tXhqT6jfrsZiuo5jTCqxOhwM60HMfiwmBCIbMa/7YyRiY/Rf3YJGPWvUG43oLE28OKBTOBNW
bIoiG/d6oL7YK+prGfp64klPX6c3fJ5R3vUqc2Vvr3NT7OLDHuhPD1Nm6rZLf1JXGz3T7JkD
mqdBFEZYwCts9BPsO+/prU5L7yb1N1skg79I7/YX/NflrY4Nvy7XP6uDJHVyIB+lLfE4bTlf
T1vmo7RlfpS2zA/TivjGtGV9E8rWRLExqg1ujOKaZ2m99R9iUQ3o3Tk7IUFiw/afc9j7DiMn
xng6Gk+d8XA0NpFcKlN0jbB2fKGCkwtrF3v7FRiAuAN5kNTtVsHGA7xN823Xy9kRDDtVBzTY
jovdKr4n1x1YQ2ZOyGuL5k4JNiV1Vsj4IDopwGv+2ncAX+TRzsvvYS1SaOjxiRDyMUVshEOL
F3+nn9TonvNhFlRJEYddPuMbU8adqjHUi0uWq25diz8pps4CEMBI9euIDz3kp+U4oaiEgSr/
sQS1jLv+yPe8YeC2P+k49lDlIPJ8lA2PT61q4uStszWy0oG9N4aOldXy2/RXAVL3Am93IGha
LanKRbTDSHYeQmKn7gD4AgSVTUUF5Oqn4EuGPX8A7m8l3kYeTTIU+FQFw8tL07abuvcgPnm+
IA/kSJ2AISO4/Tn9glzRbGS1d0G+e6/E1JARarxrrhVXSg/lWcFpDdrfmWA0RRDeYbEbulFd
Y46sIesCoeIrJ/uP6ib3AgHsviMQeCTbh44sbTldzjho6pj5qIYAamj1cdg1Kn8Zi3fSl9E1
n1Z5gZdhCt8jklMkiVAqrrDDrMPjmpCmPTDH+0SPSbYG6thTXcUOx5b9cDVrmHVwLKbzKUyd
8oqqDxolVzLdshBnacbLW46J3mV+9J7eMW8HUUMr273XSrnihNrENjyATNYYtSlXj9Ihss7Y
fko6dJ6aDb81r31rNjyO+nGOLjd+xJ66Wp7S1QuUU1TEWe8CIcV7hiolOnup5tiZLNT0vJCN
n9m5rIGZ8oPPO5wJozWf9vKLpNyt4H1TaQOh4FPOA7Jd3xAStgdprpNMd8jp6vLCC2jD951Q
9BnsxovVYThm957lNUxxYxWa9W6tfliPfW/MB7Fgf/dYsP/5YmH4fWLBOnY+/9eFzOG1N0Pm
MI+WqOreWtR5hg8RvpiH8LIrK4j2kQ5ZZtznAVTX+KBhXJ8xXE4XvdmC07KayuoMQsMTFLUi
9dMYuXE2nS86dHWGD4hjAp/PFxAZP0TRhzfDaUi8O8EcgdQWsgMe/FLdyWlQMEY9biQPjx+o
hZrAhEhu8KW6U15FSd1s18PmowsKUlW4ZarU8+h76q8o9kcnlR26Fkjeb9aCtcOwt0xRx4J/
0d4+W4IKVOVF/dUChnBXWBRGGJkqYG04zgvSJL7XtWe5EGxtmajIr/8gYE8T+N4/hEiwD23W
2OUgmL2+5MuzLMa8j1UMoIz1h55qWmNyvJX664ExuUeCnQMwmh+CZSkRtMH1xj96MMOHwYz+
2ME8oWenBlu/r+eDNajWSZWfasZcX4WZPesgmdQij/LJ/8zYf/T8o+cfPf/o+UfP39SzXF3X
7Ky3KuPt9U6ux2qPCKrS0CiuC03CR833fF9kisdwsaj/FuPEAhdgPnjSNU2j/XSTBseV5Vtv
K8qsefKduekkCBi6vPUyeNp1sNPfEt8PdWXGxyatLI/SnC+WuuaxJn+PEPi99dv+pw3fHz0/
rWe+sBnTUt0Q3no5X8FK7FTmE7J7/Z7DR268xMMyUX/i6MX6t0D+P3r2R88/ev4/2/MfxhLs
b2EJf5xJ5pOd+QBGs+n5vwEFW2sGSDUAAA==

--mYCpIKhGyMATD0i+--
