Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCZUWD>; Mon, 26 Mar 2001 15:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRCZUVy>; Mon, 26 Mar 2001 15:21:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129051AbRCZUVl>; Mon, 26 Mar 2001 15:21:41 -0500
Date: Mon, 26 Mar 2001 15:20:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Slow... pipe/socket on 2.4.1
Message-ID: <Pine.LNX.3.95.1010326150320.4705A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1295196120-389210690-985638002=:4705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1295196120-389210690-985638002=:4705
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello,
The attached program attempts to show what happens when a
server tries to talk to a forked child on a UP machine.

The response time using a UNIX socket is awful.

When the machine uses software compiled for a SMP machine, the
data-rate is about 13 bytes / microsecond. This is not too
bad, but less than I would expect.

When the same machine uses software compiled for a UP machine,
therefore not using the second CPU, the data-rate is about
0.4 bytes / microsecond.

Running this same program on a Sun shows about 20 bytes / microsecond.
This is more like what I would expect.

It seems as though the problem is that, even though poll is called
(which should give up the CPU), the child waiting for data is not
given the CPU for a long time (perhaps the next timer-tick??).

I have not tried to use a named pipe for communications. Maybe
this is faster?

If anybody has some suggestions, please answer by the end-of-the
day. My machine will be off-the-air until I convince (@&$^@$)!)
that Linux is not a security hazard. This may take several
days.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


---1295196120-389210690-985638002=:4705
Content-Type: APPLICATION/octet-stream; name="bugs.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1010326152002.4705B@chaos.analogic.com>
Content-Description: 

H4sIAGagvzoAA+06C3AcR5U90sqWFzlWzglxwHCNY4VdIq13Vx9/FAfL+jgi
iqST5NhHcCar3VntyqsdsTvrSARDjKwEnWxKPi7JVV0cwq8udZfjwkHufAWX
S5WpcnJXgIGQcoGdMlQoRkUIThESY8le3uvu2ekZyY4DmNRx86p6e173e6/7
vf6996TBwlB+HbmyQBvC6xsbKaEIYVctELo+2rh+fTQcro9QGglDTWjjFZ4X
g0LeiOUoJTldNy5F92b9/0dhENf/9thuLZnOaFdoDFjOpoaGi69/BNcc17+p
oTFSXw8NkcZoA6HhKzQfB/w/X3+/v7V1Mx2Kx2ndjlgmQ+t6on4/fGxals/o
9/j9+Mu/Q3H/srWB1tYgrdMpNlDR6o9ntFh2k39ZboTWJSnn87/dinlwWcDO
P1/IKzbGm5z/xvD6enH+m+oboo14/qONUe/8/ynghnQ2nikkNHpz3kik9VDq
Fr+jKZMedLYVsmlodtPl0tkhZ5uWy2Xd4sbz64z0iLawdVTPZBa25vX4bs3A
dv8NCXigshrdur1D7WrvpuExcBVKrbd3tvb10IjWZBO29/X19PUH8kHrkfmI
n9J76aKAXZQmR0EJIxkA7WDutXRNey6n52gyp4/QDIqsSdRSfCVpTb6WxvGy
xI9ATT74keyaWiFFVbs6u9tVtRa+Ojq72BfMopaCjTQUGGCGCQabLzUXbSxt
BNp3dg6oHS2dXdv72pEcu/ZSvx9mSUdi6SwN7NHTiWCz3RII+u9l/PEU7OnB
QvJOYa9dzaw5n/6Ypho0o2U5jnz50TujVreRK8QNiku0J5ahxh5HM65RMkFH
kwnenNALg2AMPD4GqqeP1lJDN2IZ6ObSwZZsBUdj6Vygt0Pd3t25s5b297Te
pvYP9LW33F5Lw8A5GqQ303DQb5lALN0am3lNUMzknrQRTwWSem53IMgZhL6x
vEbDm0oiYOh4Rs9rgf6Bts5uthDdPUF7CHkYRmiN4Gbu2T7wB3AD0VvnThRG
owFYlcgusJU8faeVZDHIcmkpkh5/iBhJobckhkmgt7hElCjudcgpWZBxuSx3
SevtLX3BFgk0N19sBNjDIdjKDDY7jNy8gE7bo2WNPNL19nTB2V5IkRMkm2m4
2a0IHprAjUBVSyO1tC6yiNlkjZBcVsiSYs/jRjENp4x7F0gErgCcc5hUTosl
HOegFm+GWusqDV5kSvK0UIR7WmKQe3Jpw3VShHwYPUjft5kG4JYJMuySYzBB
7kH2LrK0gzCb3c32sa+L2OfeEoY3hCULHoRYIWNsusy9wS/VIc3Aa1BPJmLj
gRuNPbW0e3tXl2t27OrDnRHgd2EQrsyQsUfNa3H6Af4oLcZw0wKGAnAsWHRu
WTgD4V2uFUOrWt8X3UqL2tO58ZnsP9cdv5jhfs+tvvf33yD66FvbH0B/OduD
vbO4gshQx/eVk0LyZvQCvM9rapJ0cNzQ8nQdLeSZw1IaxXKqPkCj0MtkL7hU
+W9OMwq5LK76Xi/C+7OAUvx3BceA+O8S+b9IY2M0IsV/TRj/hRu9/M+fBD7Z
3tWhKEoJLyPlBLHU/b7KBqgfX8HbYTlIBQmQ68k7yRKGQ7kPaKA8Bt9YKqD4
oJRDeR4L9GFZCd8rRZ8iCgPow3K8ihAsyE+qeT9rewT6oJwF/OvQuET0l0G1
YTmUw75KLDOAY1kixlgHQeu6TKIOorbCWCivh6KEXA3t74XyLijXQVkFZbWY
K8I7oKCq10BZBgVvt78Qc303FJgOeY/QQ4ayi9jVJ+olwi4IlVJ/tfR9FZSl
4vudhM/VguuhgKrk2kXG+Dson570Vd4k5oq6oT0Ik/FqsQImX3nAxj8N9bPQ
38vwlSSFdnjUxp+D+u8nOT3KewpKCvpRFwr9L0o40n8Q6jag38HoK8lRqB+X
+E0XP56fI9D/ftF/gfB9xu3hJ+04P+hfKvqfhnJCkvdPKFPCD0M5K+ErFa6f
pe930OYgf1z0b4RSBfaIMPwdZB/qD/0bRP8PoATut+VVueTdAPWZR2z8L6F/
/6M2jnbYAPyrBf/HodwK+BGB/yuUnZJ8+9ShfQBUdWhEz6rsOVdVAts4jtu3
iahtf93dAg4DUbd19Wxt6VJ7Ojr62wfUgZatXe0qUZPpbJqo8GOADGRj39Cc
y2MLSzmoGT0eM9J6lqidPSrPcqhE+AkEMw4kZrBK9IPfoBIrbUFkh4egf01Y
+EVULbsnnQOp6DkR5nUSjAAJenbEjuFxGoLSqp1HlKsN8mASWCViRgyYBvP5
Uk82QRpgPZa8h69LhY/v34oKvs8qwLLzsD5L0bDQvxQOnw9rOMyVWMMhrsIa
Dlw11nDgr8EaDuMqrOHgrcYaDjnFGg7dWqzhUAawhgNWizVcCGGsYaGnV689
un3qZ/3mr4vF4r6jX4S7ZeIbbbiYRoX5uY/NvXFwDzE/CxMyh2E207vmp17e
heek2PgazLRYc1bsp2INzhxPJJk9DaKKNahBCvtmjzMcNUnhtTH7DMNRoxRe
Y7NPMhw1S+E2mn2M4ahhKoD4DMNR0xQ+qbP3MRw1TuHWnx1lOGqe2oL43QxH
C6RuRbyX4WiJFF4Vs1sYjhZJ7UQ8zHC0TOpuxCnD0UIpVGi2GtDILye/byzt
M78E3zvNbvi962Db131fxHWb+unES2d7e/vuMP/tQrGYwiNqfpzRfQrYe03U
57WZmRmw88TmE2iwwoZfrJh6/WCvb+ra5wGfJsXjn8ePiQ2kMIvHjUw+Y/hT
J6HJfNf43BvHKpANtwWaH+RghfIs2hWpDEyEM8yOzb1h9Vv1vpdr4abfcUf/
wcNnzxeL/cNkWJl6cVgxX4IZT3yrevKZvRHThO9pmG8Y6t7UFlAjdRv8DNPU
3fiNW9Vsgz5g+zZUM+YQMp8trtj/lTKcxYrJF6AeJuZ/M6E+mFfY/KwQ+uPz
KPRASWiNJPRX55nQMS57X4k7am4X3Idd3O+XuL/KuTcB6dTrw2Vmi8R/reDf
5eIPSvwf5fznzjN+Mt3q6zU3n0cZlWCWqPm981zG9UzG35Zk3CTJqOMy/p3L
UJiM387bMg4KGT+cd8qok2TMzjMZOS6jjMl4SpLRKWQccslYJ8n4MpcRYjKm
O3wTZ8s+saWX4dwk9WaZEPOheadJ6iUxd3ExP4cKzv/B/zqD8i4cfJCgjR88
CdixSWzD3Zc81uFTyIr/6PBNdfiGge0OU2ezroJZw/rPi/Wfw+EeLg3XLK//
HF9/IH19m08xvpBCv2SaDdQH+wn7p46CxH6rTTH/eY6NsfHEiv14/s2bxDh5
Ns7nS+O0SOM8wMepBlJzbo7TtzL6fyzRd0j0Ozj9aai4DSwLPM++TbTKgyfw
9wXYN+yrzxycQ+ucFtY5NvkSfN23P9RyirX96CDjegppf9ThO3UYG4W6KLVv
ehIPaK/5v+e4ztfsm8Ne2MudYsaHzjk17JbX/xxf/zm2/kzUFFup5DEwLKzV
NrjFcZF2mP9zzlqkevOVc1x00znnIvVLoj/ERf/gHNsTbJ2u63dNuoPLHCZ3
mHfC56mKZ4CdqwzKnvwyKnuq4llofPHViZcrT61em3oCB8DX0Jz9LTKvmv0q
3i34Jn3jNF6Jm/G3aFwF+pQXj08cnZ9oLhZeEy9R6Y5zvWM/hodmxpxGtUpP
1qIgPfCL/hXx8v+I4hcOhe08SB4FczgcKQwp/YC7g3/N4PtFXhZvKntXi3wf
WbXlHyN8BnzHR6F8BcrTUL4D5UUor0C5AOUq8NXeCyUE5RYo3VDuEv4bviXV
oj5DeHyAvjD66viAoc9rQmyDvv+BCfBZoH5in68Sp71W4fEG8lt+PcYh6Fti
PDFKeByCcQDGKsf3+yrx+0mo0W/ERx7jEDmeINtaWzfRwLbu7UEaDW0IRRwt
2lA8XxcNbYyEmppoZOPGjeH6SAMNsOZIKBKK0pyW0WJ5Lfg2svFpW0qhYcOR
UDgiKfrHaiOh/PiIERuE2sjxOmV9gTes5UZJKBXLp0goMZ4FUl4bORKCiYeG
dIN/gGvKP0YzBjKC68w/mQcbYk55KKczRzbEf7WUmszFRjQSiht6DtgTvGIy
YZDYSDpOuOC4PjKiZaE5qxuX/5857xaq4j5i8TdxxqxWzIGxTIWgw32Ksdq3
iB0P+0SBJWJ7Felw/z4BAk4rdiyPNe7jiOBFOtzvB8r5PnePizHYMkGH+/lJ
H18i5L1ayEN8q0R3BOiO+HjMXk7sXALS3SbR4Tk57uPnp1y0W3QDYg54DrfA
Od0Cysv/X2bF6x+W6MaAbqyCn2+ZDosq0WEMm4KPxyoWytMkOozFK6tErOei
203sdUPPcUsVz2lYYPHkBR3qx/IjVfzuccsbl+jQqz1ZZffJdBMSHT4Up6uc
94pF9zcSnYle8kXoDkl0eJ+dAbpbXXRYHhI2QTqWx1nO9fVJdCj/c8TeH/jK
PQt035TkWXP4EnHG00j3nIRbff9C7FwLxu6HIBZMLEJ3NbHPAsJvgO5ri9BZ
a2bBDGzO0Qq+V5uIfT6WueRhYuevJEZ57m7Ac0wYP6cySzgXgOeS43wEPH8c
59bEc8ZxvkGPlHCWUWPnhuPcMlsmLZxbd6yEL2O4lbMpJ/wRtnJM5eym4PuX
43xnHn/Ewpcz/GQJv4rhp0s4TzaaJZxnyc6UcJ4Zs97wcpZFsXM05a7sXDl7
Re0cTbkri1bOsm0yfp0LX+VYFx95tYgaPXG/5UP42X1r2asM7EUle5SBPWre
hB8D8ucfsXyK5SyvapbwanYPnpD6uyX+MuBPSPZUwJ6Yx39N6scIGkPbVax/
JZmGel7qfxjq1Q/Y+Bcc8paTJ4m9PhClLKrPiWlbn6clHOXh+/OSxI/jkQMX
H+8nxPbfUP9XXPotth6WvXH8+UX61z5g95crzpwp5vjknOm1rpzpasWZMw0o
zpxpg+LMmW5UnDnPrYozZ9qlOHOmfYozZ7pTceZI75YUplDGFGfO9JOKM2d6
SHHmTB9SnDnTf1CcOdPHXTlOzLOjvb7mw34/+U/FmUN9WrHPM4X1ek5x5lS/
qzhzqi8ozpzqT1zjmYozp3rBlVMtL3PmVK8pc+ZUry+z51MN87lRulPRXjeX
OXOuW139BN029NQgchmKx6MquF2jEJ8kQqSrty+CP1ESzxl5o5BMAs0oZirV
toGePrWrs39AVQkyZDQDOOqhJ6GrQxl9MJZRmWenxgpj0Np+q9rR13J7u7q1
fVtnNzDhiGqiMDIyTvTBYS1uhDYQ5hiKRpa+5Z8Q+sQ11dBVkRBtlcaWx4tL
4zGa9u42RtImI3waHBMBWynFa2eZRQ5WygPLOWMWoZWyuXZelyegRcAm8sow
Qy2nDaXz4FVz1xeoknop27sgW82CPhbuOTLOciIY/9WNR4hoEksSc7dFBltO
O4tE8uKJc0wpL8iP8yS4KgtXF9NBJMCdSXsPPPDAAw888MADDzzwwAMPPPDA
Aw888MADDzzwwAMPPPDAAw88eBvgd2RMnLQAUAAA
---1295196120-389210690-985638002=:4705--
