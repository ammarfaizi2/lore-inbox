Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275249AbTHITFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275297AbTHITFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:05:00 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:46184 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S275249AbTHITEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:04:54 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: video4linux-list@redhat.com, kraxel@bytesex.org
Subject: [2.6-test3] bttv driver doesn't run
Date: Sat, 9 Aug 2003 21:04:36 +0200
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EXUN/AdmHKKyRM0"
Message-Id: <200308092104.48878.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_EXUN/AdmHKKyRM0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I'm running 2.6.0-test3 and the bttv-driver doesn't work
for my Hauppauge WinTV PCI with bt878 chip.

On booting, it throws the following messages:

Aug  9 20:47:06 lfs kernel: bttv: driver version 0.9.11 loaded
Aug  9 20:47:06 lfs kernel: bttv: using 8 buffers with 2080k (520 pages) ea=
ch for capture
Aug  9 20:47:06 lfs kernel: bttv: Host bridge is 0000:00:00.0
Aug  9 20:47:06 lfs kernel: bttv: Bt8xx card found (0).
Aug  9 20:47:06 lfs kernel: bttv0: Bt878 (rev 17) at 0000:03:02.0, irq: 18,=
 latency: 32, mmio: 0xddafe000
Aug  9 20:47:06 lfs kernel: bttv0: detected: Hauppauge WinTV [card=3D10], P=
CI subsystem ID is 0070:13eb
Aug  9 20:47:06 lfs kernel: bttv0: using: BT878(Hauppauge (bt878)) [card=3D=
10,autodetected]
Aug  9 20:47:06 lfs kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line ini=
t [5]
Aug  9 20:47:06 lfs kernel: bttv0: Hauppauge eeprom: model=3D44354, tuner=
=3DPhilips FM1216 (5), radio=3Dyes
Aug  9 20:47:06 lfs kernel: bttv0: using tuner=3D5
Aug  9 20:47:06 lfs kernel: bttv0: i2c: checking for MSP34xx @ 0x80... found
Aug  9 20:47:06 lfs kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not =
found
Aug  9 20:47:06 lfs kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not =
found
Aug  9 20:47:06 lfs kernel: videodev: "BT878(Hauppauge (bt878))" has no rel=
ease callback. Please fix your driver for proper sysfs support, see http://=
lwn.net/Articles/36850/
Aug  9 20:47:06 lfs kernel: bttv0: registered device video0
Aug  9 20:47:06 lfs kernel: videodev: "bt848/878 vbi" has no release callba=
ck. Please fix your driver for proper sysfs support, see http://lwn.net/Art=
icles/36850/
Aug  9 20:47:06 lfs kernel: bttv0: registered device vbi0
Aug  9 20:47:06 lfs kernel: videodev: "bt848/878 radio" has no release call=
back. Please fix your driver for proper sysfs support, see http://lwn.net/A=
rticles/36850/
Aug  9 20:47:06 lfs kernel: bttv0: registered device radio0
Aug  9 20:47:06 lfs kernel: bttv0: PLL: 28636363 =3D> 35468950 .. ok


When trying to run the tv-application "tvtime", the kernel
throws some more messages. tvtime worked fine for a few
seconds (video and audio worked), but then it froze and
was non-workable from then on.

Aug  9 20:49:08 lfs kernel: bttv0: skipped frame. no signal? high irq laten=
cy?
Aug  9 20:49:08 lfs last message repeated 20 times
Aug  9 20:49:08 lfs kernel: bttv0: IRQ lockup, cleared int mask
Aug  9 20:49:08 lfs kernel: rtc: lost some interrupts at 1024Hz.
Aug  9 20:49:08 lfs kernel: bttv0: timeout: risc=3D0f7ae874, bits: VSYNC HS=
YNC OFLOW RISCI
Aug  9 20:49:08 lfs kernel: bttv0: reset, reinitialize
Aug  9 20:49:08 lfs kernel: bttv0: PLL: 28636363 =3D> 35468950 .. ok


Complete syslog after booting this kernel is attached,
because it contains some more error-messages.
I bzip2'ed it because of the size.

I should additionaly say, that the driver worked for
2.6.0-test2, but threw error-messages (I posted this
to lkml before).

=2D --=20
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Animals on this machine: some GNUs and Penguin 2.6.0-test3

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/NUXNoxoigfggmSgRAjdjAJ0Q/B5QNRuIJo26ZZDTvJ5Pp4YGZwCghDeU
6yj05dEUei5k/9HYI1mgqOA=3D
=3DgUfK
=2D----END PGP SIGNATURE-----

--Boundary-00=_EXUN/AdmHKKyRM0
Content-Type: application/x-bzip2;
  name="syslog.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="syslog.bz2"

QlpoOTFBWSZTWRCPJT0AN2l/gH+UCAB+7///////6r////BgJZ77D18AeMeEVTLICr4HxupAJJFX
ucMkO3VCjss07brJS7NcuQ19oFNujERKozUa23I1JXQbYBkppqUgKglAdtVVShQUFEMiBNCYp4CC
YmjQAJoGinsgak9T0nqG0mnk0noCKRT9PT36qqmQYEZMjI0wEBo0GIwCMjTEwAmg1GbVBEmTVPDR
CbSHqNNAAyA0AAAAAAap/tVSqeo00aaAAAJgAAAAEwmAI0MAIkiBARkyE9U2ptUwINqMmg2moyaZ
M1AABo0BIiIAIAQmajEmmQxE001PU9NMSZE/SQ9R+qaeoeoZ3qdybURaGARWiUDVMAgh+wgClg2C
/r+vT/X1f2+Htux+Q8rP7GdnuqNttwRDbbbbnBEf1RQQif/+b7pDkHIrGjnyt5vtJM0V3RDfmr8n
r/aeRiyvEQwMZinuxsg+d8/7s7OJ7MMMqX0yXYeOEssUjGMYxupqSImVAxmduV/xe0XIahGmdZsm
QPyxuhFJdiL/HBq3HbWKm4amChs2hWh4KPr/NOhRQ5QoxyDzGXY6xHSTr+W7+zh6/vkx7usHjOdh
ikVjSqcTXstnL3b8x1aOivELQnzNPO1L4zwabcZoAe4OPxtHgM2SEgZ1oyaNH45nCLVfSyVMP5le
0fbnjpdXyf16nRtur3X2c9Lu99HR0bkMAAAGYBgAADGBgAAADGBgAADGBgAADGBgAAAYwMAAADGB
gAAAYwMAAADGAMDF9XIf8YxuTkA5OTkAAMYGAKYxQOTk5DFzy5AOQ7Ldd+AFAkVED37PNgAQCMAi
JFA/p95pfWpMF4+/TkAYgQBoXNjGyMRCgCzYCyFkJOSAoNFKRkkk1NClUUkXIW4+JAHW1GVr8YXg
SPzJa0Dfu5WWh4pJFXwm6v9TcuNr6TyT2C+0VhmS+916Ux47FHiHjUqFXtEBwNaiTT/vWIgPDwoK
j2hgUZtx4+QYddc2bNbjXdQIxiIxjfff0SMEAg32n4PNmUCDr2cvjb/eI72+E8izlgf0ehchC6zV
5H4ZK2m1Xax/f1T5eK8bpHAxr6VJIxjGMYxjGMYxjGMYaKr5devXt69evXw9GOvDLPPPPPPVbrkI
4y29vZAtDvQiBei620/Vtn9RsVSihI97TyBx984mJAgjR+msToMQv1c/CeCdjZBs0rQ2O0gpahYi
/klD3O+bm+Z2rKohwhjOIfTa0PGZTKzmuFvszsd5X7gsygd6T4+fRv0T+OwgAkAyCaKuFIQActGa
UAg3HxjZ/ivMyypVRfdkgEFJsIXDuxnQ0tk/dXv0K0hwSMy0ZlpHwkYNy9ZUfKQASAb369xD2bXd
Qj1LtTAqgEHz/Rt8Pfw/lkHwPScB2yqcRjJ8JC568yjo3ZAoZWSEVDpfJg0in3uZKLphzt8XbsuR
oA94CHDOtww3tfEKMZrdnpvmZOEQdFCYMlGHMwnNkUcXum1xcQsPD84CN1Q9CCMuRxnsZld05kN8
Xq0x53Dj93X2+XLH3dlfHh/D277VIiQvS90dsrnWkI+Na5yifXXwBsOVqW0x8JfShGfKjudosyjO
GKl5JBOnNIGx1qWXld1AD8nUYIQe7128sVrFtu1h02EBdqeOYCFPrqfWPA0yPOh8jN5s43UXueu6
LHUao1nXkuSj6zDogdOCgzfgACCpAIP3YvAk/DTZz44J9su2I4wkxFQnZNRi8qL5d22K7YDN0QLB
21yJZWykXyOb1Cmtsm5UNV/dVw1WdeHiPbX5IgDgAAICHDCtjChAIBOd7OdMt7XDqDb0a1olLERg
yvyO0TsNBy1Qr7g8wAGtJNHfvtSSGwpY5JsUiN9xBwTLzaeuLhKh6xqvvo7X3SKKoa63Da9QJdLh
NfuC+TkEwgNPWyLI4ZHX1GM24grYOBJy1MsGt3ge/U0CNFozyZtVOwNFKMKbWM3mzmvlfkS+Kh9X
pWa64yFgZW5/TTyZO+3G1C7msPI/RezQPqrZtNrNAO2kqg6I7kLsnwqaB6pzwMJz9SgT++n3Yany
zrKh7f0hbDFJusWC2WpSw6enGW+jPEp2r3a0yP5X49dFXjWymtgJIBcp1d9LVWtbj2+fMqiKoqq9
a3b7l9oRc+fjwZBAAgAEBIQCRAJCAAgAIABC5S5SlIoCQEExZZZZZZZatWTM11VV1xXXMzMkABAA
IAEACAAgAIACAAgKUpSkUoACAJmZmcVrfOMYava1i7td1rGE1FnhtYeMu+cgXDA8Zd8t5Aw23kAL
gYvGb1w1fLvF7TbOU3mpkyN5yXy3nDebhnJi2QbbzkBttjbvvtoCAowEUYk2EIGfOct/TDt3bL53
9enG09iAaxyu6QlM8ggUEtrKqlBNXfLk5p1f2bu2Wgfy6zjdJi7DEp3Mo3n/tJ+HKKc18eGPWbOd
kjCTPW07osECDwwkxFGaAeFWm4ZD4+5RULh9RtE2cDUqC6eIPE2jQ2oWZ6abn9IPP6JCD6avlSu6
Y8iCxa7mgA9Ov0cvgBeNUAYIL7wBB0lWLHPf8cyw3BMCBBtv9vyUAEGFI2vBn3bdchhQrdGoDxOu
HordmO39mB6dt1t33nDG60+j6r7OPfOdy2z3m/E74vVt+GSL3U3WuK120AEHkU5erp2254xwg8gN
Gi2/0HblckaBE+mVmGyFXtQ/rmdI+xIYuE7Zl3P8znZgUsXa3s7bOmLijtXidNqmJVKf42Ky5/DD
06efc7Tj+WnnzR6xjaGMX0+F0rJh8wNjRB/EISF2jW3bAgtQMBcoCA5z7u3sCWOZkJZR/bfO1r6N
nu5UR/vT+lXG0q1HY+mdV6UExQLs6hIDXs2UsCLCeX0iSaZ+1tjfQGKkkL5Rpq2SOqhq0aUF+mEy
eaUaJdTHXxYLPK3eeXGQCPhlcmckkAZn84p0/4mvDOz0PZ3EY1Jqd4d/YAIObVbLr72STye4Upuu
JLoxn517co7WfCkegQvrGX5myqNaHgrDb+n1SkAeUka9PqAd3jHqYTvI+arT0Ejzhi8We7uAA1J2
wbNL7Ve943+GiMB55Ofj4HQl3W8jsWqboSjgySMHBvMkT6LOL57Y0xM5O3pGxMNb4yYCSPUgEDQD
1vgJN/wkpZdL9kAZsD0NX/03eV993sj2k+8tqhVQqqHH1l3zyhXWuLLKxVkzAUmak0mJbcsx+vee
yezH4U+ByX5csJj2gbArgnMK7qTYbTpaJ+sbp3hvdRPR5KXjTPx71SB4fy5kgePh3kYBYG7S8P6q
tcfQcu+paVzCCx+pud6VoJJDEKbFVdY1/VliaHhjEasIo1HJu33aYPy7GSC4B8opEQgDT46ynywH
5d3WgIWDs6+oU4t3ujr5baaYzunTkXJdYAEIK1AAAAqquIJbkmt5vmfTulZWtNDnXWqRxz+/sbcQ
sU3VrXdnavaXsv027L8j5vmnPazXb7K9tUK9oXreMhOQaV7gPE3nkYiSR4LCC3SCUy9i9gxjUu7y
QQFaOs2Rr2RbUSSOHhBaXG5jgwXPnhnxnH6Bi7i5EfVdk3IyDQvPfldSCALBoSCBduI57twcd5k1
2hiKUiYCX1ya7md0QMTPIHDjenItlb5MKxGcsLX0EQhS6Y+g0DeY4j222Wv20Aqmb0wdtlUBjsP3
F2ON11ySi55WKlWg1Rhl0AuSMYN3humFHhCAQe+ZKDHsrDUwdSUgQQ0Ahxw9uxc6jc7IK1BkZHwq
mRkCQJGQLNFMjIyAMgASCboMBVSAQQUqgoRUjARjFIxCCFBDqOZqqfZnbHPso1KoEed37sXtL66p
6STD5qkYMvCwkuRELJp6paJrc/Drm/NJ/Eo1ePK7YmZlLEgOlDxgBgMQhgdiEe+2LmhGO312+Xq9
fP31wMTu7ju0rWoBWoAAAFa1bKygcTJXqrqp3UVM+esTsdMu61SHmmMaPnHZ0A9OlKP1bA/sHU31
MjhM33xqqKNZVbKFvCV0PpnbaiRFaehTOp4XdUSMxUzMINkL5eLhug6uEDJNmMB2FKsscINKTspk
5i62YdEj6j5NtJZit3y2Gy6zBwk15XBoM8ptrYy2AIWpkTIb6ylFNuTVjDbCvz6my8SUsSPdGzw1
uQgNFsOxJID8QKUu5M971npPOYHS2XjbEcfNHkHTxrMddlqtTZg5QBtpsABtOqrWrmaQ61rGPmbs
8C3zGGeB4EqofQW+epRDHvezw60FNNu23oeCqic+rmEhoBIFe8YSrV4wTXpZIpMSCJgU38pFfZgU
zM6yWCuttaRxolGUyBSPEvVlnZYQQo0uul73/27AfC5pzDw6fCHV3FnDxxTtjj2rs92xwJ7a7FEl
RLRu08OIAbabAAbcVkgkmSewLt24ZWylOa7XyawlvpSt9e1xUfexHnrdphn1ViMS9LoWoevq1pKL
DYywQEPoJKJPoaCAQeCsMbEnobIlLDMJueyqVk3FuuQhkXHDt0qIQXZl6pwrXJ4vlSLbR4+GcFdN
KaZAbTTYADbitYUNkzMLuZ0Mc+Z+hbly04V2pWGx/SZCqbNeNyW3kOwrSBi34F2NFum3GkNWT6Nl
xUFvQCC0MZSgtgEkkVpnIElNJSoIQEAkViInEuSnCoOiVmhLUvDwrM9cWhwStsYWdXCht2235AAI
qAwAAiAhzLlEdpa02U5919jvO7zQCCm8DoFkgy2ghJEnSBWUDUkReOvlwxwU7YOYGp4yWQ64PUII
T90A6rtwMWu01YrBDGlRoNrSMeH97rzMrmanYcMt9qbK06MR07I6Izh61iLxSgqKipR73xgAARFK
QAAABCiKTMyATMA3KSSSt4MZnGt+eZOOJW63sMSMbrW+NbmZwgEHQ4wgEGSAQWs0yKxlVdhJhZTT
NmC2oBBSDTSbq1akW9wX2PkxHJxTN9M8gADbbQhCEA202DbpSsiM6KFjvgpYhX2VKxpd9k0HiPex
/XEK6Nl0YnbfO/hZeLYys6Z12wCSSK87NCeLK20Iskpxz14WXLNcTArmttgAAq1EIEAAFa0iogc1
rWORyo4VzMQoxCpgZGvH61Gu4VAR6YjjGeaNV0NZuPakbCKbfR55+1U5J6YoBBgTi9HaczyILlpn
sxyQCCtZOdNnKDhhSvStdde/2/L38Qta79u0QJBTKN/EXnduEIQgEIBAACKOZqQ4Iisup6VDL5Kb
8L0bMbyyUAg/7SBiFr3fujN8eSOW7M0DZW4QU37PrDt9npPx2/Y/ofij6jiVCSRnvRBtJFNIecin
4H5FP1WbwQ9OPrzT8XHnY2yRttsY22229vOzGtN206VpXbbluar92P/UyvqvyugPqIAIErQxEMoW
lLWtartPle/CdhTc7GHB7WZUqrj8WYXvkeoIamCDIgMPxVUxQNsJIHpleJnvQ+221hztjY7mCTZ4
MfLZPi0YtbGiLf2SgIQCB387JCo1Vyzzw57vOp29L52Na5Q2uaBC6xHgOZDbcZKUFWIQJclQnw4c
+OzFCwuG1gXx5be2qvLv9M6eTRg0mwME7xo9jUtE4yTsZt751ohbH6vGm0OMMsq0IPh419BA1xQ3
OLS76AEPL3ACDn42XM7bTjMACBpc4Oye2/Oqi23+dqpU7AuOy70Rdttc8jWJWUtK1zNVSSE8vnER
atS1RCkACNEoT7RViqpqWTWh0f56nJ1nPQC0GNQY7uXI0tQJkFOjlcjg4qtWq1a1aq43pSrVarVV
V0SrWqqqqq1VWtVaqtVa1VVVVWunKqqqqqq1VWqqtVarVqq1Vel2+545uOwtlVVVUkkgKqSQjCSE
gIpCEhIIrqrVtxuKqtuKrVxtVa7+BNBFlrWgHS53PIo28fwOn1vwXec9XeT4fEM/WpAvb1el3d2W
kpJAccTHtt86GzNIEH4Hos78z7Nfr5nY+lQNSghVI9N+CeHft/UdCPxkOLA+iD4+gcG6ifbwAox7
GsPM0S5AG2oib5I/hn3aFQguSsZUHwMPmYfYgKDD5w/CY+iGfB7Jsi1/LfqBOAT5I/r6UhzQfjDv
pBGhYqLlQGt5Wt020TMeqWdtGtBHJU+IBHOrmhuCkbRFdkYRLP5vu8/5nUGWM2WF/6Zn10N1w/84
8V2EQpIDqPaMRzqadDd92luznls/o7rezS8P83HcWAIUmmQaSlljH8CdtlOOaSEohM6Ywjt9NtfT
4WXMNQYCMIoIayD1+5HtwQR9ckIQIWiOC8g4woIksmCjSTVKTpu3ueHPttf4swxgcUGetN01EETk
gj08jWvluxF+L08uwBHAl/JZStJsP3nLN8fIsOSAQTAcOKAQdQELakhKlybaDP73sMjbAWGBdwQu
WH3NcfKPOY4M7PrznsH9bR0PqjxYrOGP2IEkoOFKg6/KpVZID0qE+vNhTZKngAjggr5h8ld9YAPh
c5ZAK3tP0h0PamU2ae0p3GltK0CPfBT1cgxCAtkRBbv+UBCm++LTgNI6Tq+6Y9jSD4P58OgCM4KO
2bzQ0xM3u7fHcAjhggj7mQ7MIglzuifW1lW2LgELwhi5DBVPtW2Tk1X4+46rbsQIXqe/OmuvzHTr
KxKx1IOxBGKi7dFDQ58NPL38Nge6XHHq1BbH1Z/H7HLLxnk9FL0V/XQwibIJgX5nELiI7jhSCORH
wh+TnzVF4Ya7Yvf8Hv0duvVViQCSbPb3gXgIQGATohP4KnU+r4VHx9XZ5JHhznOc9yeF3mVYjDXZ
p4P/dLMB24j2r7giIRgnu8GexPXzr3JCOGsiV48/6GhfeL+QMxHcxHjgHh5FRcDAJmSWoaCaLfkJ
vgB5gEOHmTLgZ4T0nzj2EtyFN+0vlAQRiwhiN2wvAX+ig0N+BGWBtVWT/4pVusC/F1mzhSogQZla
qls0kjvyLPPLS13d2H/z+MYVIeVixuQFKn6jAI/NxVF3GhdQz6QpLw325BSFQTAu8KyQoHQviwyW
k+SOx8swO7vbWQNI5ELzR8uMcdS0tRmRuuao5fH+++28P4ZkUbYURrqj+FiPb13ILKgKdFntcGP2
5V1clRxRVAbgMhqAdoKhwoMhvEu4OTJzKoeEAEN6pjBofm1uJY9vEo9rx9RCyiBLWILQcsRzYL7O
d9RZ3H2L9oxjGxjda1quKq1xVVVXFq1VVqqtVVaqrVVaqq1VVqqqtNttttsbbY2349ePDkHu84DE
7GaJJAStKehL5mG1eUHmN94Ag+85IvNWQD+aEqe4qV9zD1dsAeUR6mKJ2klbQ3D2WsI1zLapEINY
VBmdxhywrNsws1R5qAoHLBhjLzSKvrxPCkkmQzNFBWYQkjFxqoAh2StJRCaGRCd3A3NgwYdUCiSJ
IytLLwgWl41KhUKJhAHne97p7GVzLAN1VHzlIFQsqgWJU23y4cAOwvNlSylk/MBUTRrceZ91youW
dqSOhYao6BpyhQgbd8OiMGbKevuttogivBq2lDAh3tQaeqyhc6HBNPJpJAJORlUS2m6FgFaNQKzZ
mXjXqGzxn/YAQPuKj8SuMh3yZqGiL3aI5p4VrkDmQ0mYq1jQ0NMHPAeBLECoyPmpvpTN4rPKsGWN
brNLopnBjJDJvkL5lu8MJY7IshRflh68rgpQjv1O9khedyRzzplU3GriCmtio4mFpv8DpsveP4Fw
ESfJuWJxFAVuX2MCttgtUL881DLnU6WJqVxzK3lCZkgkjCTQ3U/a7MroltwK/CTKlClMLLZyCxWw
JS2FjWRQdy1CcBS/XrPJlggQ10IIb4/m3X2FEYM3UCoDGtIATdTgkD1aFKV5lAazzyEvKJPmbCZq
LuJkHdEE54FEv8LABBcFNvYSiezIbgHdbEOU09esSnWFzI7FburY1twvLJSGcW1NgGTKi+esllA7
bj4sAECw4K1ejbFDvbYmM2GCQRTbn9LUfKK914zskRPCjTU1l0arvQgRbQOnqL74X1fC6gyvDntQ
gRqtQjTIa41tLbG1OasMBgsBpXsRJ4qzBGHIXs9oQEV+Ubn0MPgRB7LKvkx/GlQzPeZrxuqPxX3h
lNCFuLrkZpJAU+XJfqBcGKwCsiKBzgvvCgwvN668BWSN7IRPxhCJr5Z0UxwReicmIqA/aguDMJa8
hbc/f64bTR1GPWgKDVXgbYt4l43haChWykCDHzD1SWHTIUERBjAtAnEWHqzQEjGF9lqPJA7RVRHf
vcOAviDYl2v8JoFabaUDUoxH/SD/kgBCCYYBItR9MkTFn7fgwPvl1xh9dwy8oYYSvtoF2iPDztwI
sA+AU6MQILGMi3YHP09nVC+gIg+a3APIh6+gBaznwCf5NtYMfxaKngmNQnFTfF3Ip2iQBxFJ2qVC
B4wu3ZgCCBgI7dPljlkRGCZ1hZK8szx+D2l+c7Ttmb3+7rQzKUnAkht4WjcO+oN0IcPlSyxMe5zZ
SPlZc8bSrRnmbeAaACEztSnzLjqN8NxiU0RdauoJAGDCSotxrrkStJ34GGgvcMN53QhFcwBDgOzo
kOxA5nE3k0oudR3rYQQ7p2SACGhsOV6CoqWt1M1hYAQ4JDYP3G0FQHvg5rdEe2kfnDI/fjBSfqL6
KNMiyYw4lmYgEDGTMi3q1kPYop34754wKYZQok0jJVpawVIsUEkUQUhYZ531aMgfbyyrxqz+6+59
LGUaKYwNirBJBncr07FUvhX4STe7lNlvbagEgX5Ts1KBfTC6bxp9sk1sm2WIEFEyWjQYx/VYlcWf
f8dTtQULFcfJzkOTjJ/PJYUW31Mk58A9I1mqWpJnecW7m6RDLwZNEjsiduSnnYa0ju2fAoWITPYa
2zLA/12zsPBVVKEJL0ab3voj1m+xIEFjp0QMxZuKDg+TLblQY0pGbx2Y9ZhDo7EXmWVAkdMmItYi
HY16WrGFoUfRTUCQku04BCydAMrWDqMC6fUwvfysaJUOJMT9rguVqaL2S022+2CSlJILqMJFx4U2
7xYahoiKgMtkGVB5HPOW5QcZbhqFQ1wfo+krZtkTOwIh9RVbsSuiF3ZBdRUmxc4YwDZTWBjHFIpS
cayxk1EmMkkxoq43TCyuBEyMcANw3rba3qyqzdgEi4G6N554/bgnOe6Hvw9zMaYGspO4gOw6nnEB
ERoaK2S5o2h1ZK/EwzaPdUQILh9YSjQLj2GuxSAQ+FfXQClq3pJm3+ME7nAMJVKYBVOfw4EdQQP+
x1AYZYmNxcoe9Et8/f+3ibkmaBx3kPgdsqunf26andv98YYEio0tzSmaq3yC6yhQfA9tBL0sort4
2kHJoUnNsNT2H2+HG2A5KeEDSYfbhmLx+mA1O019LZj8VU/3F42WeQAg9B2C6kYG72FfKD1D46Wu
8TTRQmnALqIXMttAtcaKAOwgtsRn/MrlvM3z2vK9qFVZabA1lH6UgzZef1x2llfJoLBbQLITkS8T
ajfS6UGt/XzL+Lqy5rXApgoWFhSChYc1nVZmgF7C9Fu6jdbbVxq1rdJlxarWuOmVWnFxhAkIECEX
ihVSa5lCxADOqNJ4YKPfb2AFO8xU4Vk+yEGKGEsiDGIbGvTjsHUqbVylzb5qQBOcW+Gyw8IcSBiL
ERCDLALAmCzYbAW3vVS3ayGw9pgAIKHQA+mDISlcI9a0oCDkPDe6EhIR2HAAjejszPwdFuUEPADA
FfGWSWaY3qMAsJKxJEIkyopknaypBb4ZljHU3ULy9ExYP/n7XVB+LVozbnid2MAakqkr0Vnldm70
Nv1QKoD/bOxg4aNYyI2lnOg2SVdSNqOmvbZQZfsLvWVBl4azpWBvsE8EzAAQUMjxuLJqMsvLzLQk
HOXLtKACCPsv3K5pjovTJC7nOy4OY6GBdQzKrdRsIkhCWAELXsF1Ga2ZIKX4FQs0Kn2fZY22xtm9
K5ibGuFmxrFDxYsQdsYhKNpmrqlF6A24DDvcYUIzdCW0OXLVHaWww4dA0FNyAqFk+t8tkCL7SBeT
Ls28/XENpJuCVYULqtm+lZUGpXMatHDJGOJhjlllfsvZvRei3rF0cYAIYN8O+982QryLAkIAjNfE
Y4ytssybrEYsAQX/jlY7HCo7l7d+1KllmBJD3g0e5NGwWOKLx4wxaCwK6uyBxkyIcypgYrxUWiiG
LXvCAKjGnyQtuZbillIcCRAgoXZplQQgjPwqRjnJWpdFZLKt8W4gbai+cbRLlOKBYkXBgYw3L4aw
h5IjjrF6aFOzbMKgAhYsmwOxQBL77x6wit2o6RoGiQAlYt4wtyKXQQs6lLaUx78SojvrvMV4gXVE
CQKliPhTv9+Iq+85G3kaamQbjeuoBvDpSLIRRDJ9cZo64AWq0PWmXCghLs4asqDF5BXFvYwWwYq9
qqIEGnRlqN7O0uYhmKSSQn72HzUCgWqh0861KHh1hkQdo7xwexQzr8uKYxGWUq7UVtWphKMKfsoc
ymbepQKW1CQLTgpuv9er8kRDzmEMhfvBfawIqQVaMhqgNBM7Bm/8fxZXh7OUzDXdEm3cOq8SZPAo
uY5Jazzmanp6KT9majLS1gRMjcjv9wexUQ1+zEP/i7kinChICEeSnoA=

--Boundary-00=_EXUN/AdmHKKyRM0--

