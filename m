Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUKOWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUKOWne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUKOWmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:42:38 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:14214 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261493AbUKOWjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:39:16 -0500
Message-ID: <32825.192.168.1.5.1100558154.squirrel@192.168.1.5>
In-Reply-To: <33583.195.245.190.93.1100537554.squirrel@195.245.190.93>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> 
      <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>   
    <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>   
    <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>   
    <20041111215122.GA5885@elte.hu>   
    <61930.195.245.190.94.1100529227.squirrel@195.245.190.94>   
    <20041115161159.GA32580@elte.hu>
    <33583.195.245.190.93.1100537554.squirrel@195.245.190.93>
Date: Mon, 15 Nov 2004 22:35:54 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       alsa-devel@lists.sourceforge.net
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041115223554_53502"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Nov 2004 22:39:09.0251 (UTC) FILETIME=[EBDC7130:01C4CB63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041115223554_53502
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

meself writes:
>
> Ingo Molnar wrote:
>>
>>>   1) Almost everytime the P4/SMP box locks up while unloading the ALSA
>>> modules e.g.on shutdown. This has been an issue for quite some time on
>>> the latest RT patches, not exclusive to RT-V0.7.26-3. Probably it
>>> started since the merge into -mm3, but not sure.
>>
>> hm, the syslog you sent suggests that it's the
>> 2.6.10-rc1-mm3-RT-V0.7.24 kernel that crashed:
>>
>>  Nov 11 12:39:46 lambda kernel: EFLAGS: 00010083
>> (2.6.10-rc1-mm3-RT-V0.7.24)
>>
>> not -V0.7.26-3. The particular rmmod crash you got:
>>
>
> Yes, but as I said so, I couldn't get any relevent trace on the P4/SMP
> box, where the issue means real trouble -- the system just locks up
> while serial console's annoyingly quiet about it.
>
> I will try RT-0.7.26-4 later on.
>

Already testing with RT-0.7.26-5 now. No good. Same lockup behavior on
alsa shutdown, altought not always, but very frequently. Nothing comes out
via serial console. Not even SysRq is of any help, pretty hard these
lockups are.

Oh, about the nmi_watchdog=1 trick: forget what I've told you before; I
already saw a couple of freezes while its on.

(config.gz file attached).

/me out of ideas.

Byw now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041115223554_53502
Content-Type: application/x-gzip;
      name="config-2.6.10-rc1-mm3-RT-V0.7.26-5smp.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.10-rc1-mm3-RT-V0.7.26-5smp.gz"

H4sICOsvmUEAA2NvbmZpZy0yLjYuMTAtcmMxLW1tMy1SVC1WMC43LjI2LTVzbXAAjDxbd9q41u/z
K7xmHk67VtNiIITMWnkQsgANlq1YMpd58aKJ2/KVQA6Xmebfny3ZBl8k53toCtpb0tbWvkvij9/+
cND5tH9ZnzZP6+32zfme7tLD+pQ+Oy/rn6nztN9923z/03ne7/5zctLnzQl6+Jvd+ZfzMz3s0q3z
T3o4bva7P53u58Fnt3NzeHJvXl56N5G8mXc+333uDm5ujy+v0I3td06w/8dxbx33/s9O90+353Q7
nf5vf/yGw2BMJ8lyOHh4K74wFl+/xNRzS7AJCUhEcUIFSjyGDICQIQ7NMPYfDt4/p7Cc0/mwOb05
2/QfIHv/egKqj9e5yZJDT0YCifzreNgnKEhwyDj1ybXZD/EsmZEoIH4xyUQzbusc09P59TosYCJ/
TiJBw+Dh99+LZrHQ5BXfVmJOOYYGIDZr4qGgy4Q9xiQmzubo7PYnNfQVYSS8hEchJkIkCGNZRroO
i6VfHhXFHjVh+iEMGI8TMaVj+eAOivZpKLkfT66UzsLRXwTLJCZz4NS1nc6yD80WTWSZBsJGxPOI
ZyBjhnxfrJgooxdtCfxvZMQFgSxlhBKOhDAMPY4lWV6pIzz0K5zBPBZECuMMGCchl5TRv0kyDqNE
wAcTu6eMsJLoYCCZTgKYOsAStl88dBowH42IbwSEITe1/xUz3X4hTtJglU1dJkmLpL9fP6+/bkH2
989n+O94fn3dH05X4WShF/tElHRONyRx4IfIK7MnB8DqcQE2cCAcidAnkih0jiJWGyFXAzOT8xlE
hHO0+oYX2w2IJc2RIU8YwlMakEIT+WH/lB6P+4NzentNnfXu2fmWKu1PjxVTk1Q1TrUQHwVG6hRw
Hq7QhERWeBAz9GiFipixqu5VwCM6EYzb56ZiYeabguZWD0V4asUh4q7T6ZhZ3xsOzIC+DXDbApAC
W2GMLc2wgW1ADnaGxozSd8DtcGaQpALWr4jpzELH7M7SPjS34ygWodl0MzIeU0xCs6ixBQ1Anjm2
EJKDu63QnmehahXRpZVZc4pwL+kaeFWSsqvyqUbM+BJPJ9XGJfK8aovvJhi0lOQe5q4MW/BkEUYz
kYSzaicazH1eG3pU9ZxajUOOvEbnSRh6CeJ1emkgiZ+ArY9wyFdVGLQmHNxVAoTiGSjsFTzlRIKp
ZSSqtREW+wgsXiRLE4EmX78EkXYuD90LFIb3AEdW/H1ECOMyCcLALDQFwjz0Y4hRolUrlkfEDEyj
YScLjKjkvfO2RkMiwrGk0aNoQqYo8syQ0cyv7b0KgUxbERoawXjUjTLDZo7IEIRphIwwOpyZRZxi
CEdCzzyink3YLTzsI60olvY3483h5d/1IXW8w0ZFw1nMmccZnlkRg3BKJ3WnXchVBulPyozIGwf9
ib1HHZ9Li/1BcpoLLq0aoQJBRlElZBtTAxZs/wiBw8SlwHiK5gSED+sI+dockUkeD2QeOj182x9e
1run9OZlv9uc9ofN7jskG+fdCRhYClSugk2iMZaRgQwVhid8ugL7MR5DDPfglmJDsiS4sWF8/296
gIRgt/6evqS7U5EMOB8Q5vSTgzj7eI0UeIWvnMHyRvHEyFilLgsUgZWLBTiXpqio8WGW53/U0p8h
MVHZ1RnyLZheByoZaVSx4dv6Kf3oiHrMpoa4MlZ9S0ZhKGtNysxFoJGSVDZSw4RPiDnS0GBk9t7Z
TEjCiGbTkyHEUlr8mobPqUdCO3hsCb80MM92QrN+ZrQD4+1QCVHijCOzRmZsG7GW7k17U1m6j/DM
p0ImK4KicoiuwQ2pqbJN1DaQ4FoDDxdl55O14booQMonq4ZAe0iW+S772uCzRBBDR02R5awksZl8
sovqfHRGNBQlKb0Oy5sJCdhPZ3xI/3tOd09vzvFpvQW1L3cChGQckcdGz9H5eNVSWPYnh2OGKfrk
ECrgL8PwBz6V9VYz56q4mEJMoKk1Ok4NZiz72oICXo8Ys+0MjIJSUKGa1IzVlmyEalsxcZ1iJsyh
moL5ZILwSquFFSdAjJjSYWBVxcDDd0vAaG4X+FfXkk3kNQO1l03LiyFJ8dQOqs37gteHZ9jZj0aD
n6E2R7h5gl7O18Pm+Xs5ocuGVNwYXTNBTJ3p/vS6PX83iWhBqUKrz0N+pU/nk86ev23UH+WvTqX5
RjQYM4j//PF1J/M2FMay0ciojmz04F76z+apHC9cK0ibp7zZCesVKiFR4CE/DEgl6FKFmGRMI6Y9
zyimfiVzHy8Sla1blF9bpcSL6Nyg+ix92R/eHJk+/djtt/vvbznhoIJMeh/LrITvza1aH9bbbbp1
FN+bxQcICHgIUehLrUGl5YY2yDR8FwBXAclBEMpTZKoUlPqO6TisqNYVJGJV9zP7pAItlFML/woM
tzvsNxmg5E579e36zSjjAW9auu3+6afznDG6JG7+DDZrnowrm1u0Ls0+DaijllBX9cT8MfHM+l2A
MRWiDUdN7iF8PzDbggIlNke6BVgVu8pbW7TjaMVlqKCtowcj8/ILuFiac/QLdaMW2iLEruJYatRV
wId+5/5SLKUBlQAYC4gD4wii4t9/v87lj0wFM+xFIUv4TGJv7l2nqTSrwuyYROJhWPKTFYSFTq0b
kgRCLZ5+pKr0dyhJEvgjnYAGiulv9VYkmm0eQZ5Py2angODxY2HTkERf4B+nX9iYfYl8v6nxIIsl
s5izMmvM9SVdH1NYAJjG/dNZxRc6Mv6yeU4/n36dlBF2fqTb1y+b3be9AyGzku5nZS4rSVdp6EQA
Ta2bP/WSmo40R/GoKCUzeUMCCZSkqm5pXhU2aioAgEl2ncxxxn7IuTnOLmEJbAkP1MolAhppiKXf
lAxY8NOPzSs0FLv05ev5+7fNr7LJUYM0aj4X1WTeoN8xrTCDJCSYqtTQJPWlFVQi2Ox7IqbKkUF2
aRodcrxRWAsMGkg51a04qqI/6Lptmv+32+l0jHvrMVSPL2tQXSk3Lf7aO0GxrHilHBQG/koJWCv5
iOBBd2kupl5wfOreLnvtOMy76783jqR02W6C9aa3jyIjOvZJOw5eDbt4cN9OMha3t912f6NQeu0o
Uy5771CsUAbmKuzFtWC3FgfXEDiwziQmgRje9d3b1sG5h7sd2OQk9Nvl/YIYkEU7ufPFzJz/XDAo
ZWjSbp8EBfa67ZskfHzfIe9wT0ase9++TXOKQCSWFglVJgpF5pxdwVQpvH6sZ9RXgxrSuSksyIF1
1b16k4ax1UY6i+eaLlEBS3Vj+KbzuWQsCqeou+f9sgOtD8+b489Pzmn9mn5ysHcDocDHZqAoKu4H
T6Os1XwCVYBDYUG4jGoOgy/DT5rL37+kZR5A8pB+/v4ZCHf+7/wz/br/dUn/nJfz9rR5hWzLj4Nj
lUm5twVAjV3wWSVGsnJorCF+OJnQwECRIkYe1rujnhSdTofN1/OpGkPoEYQqKUkZmVVGo4xxE+M6
y3b/70123+C5WRsueNpbJCDfSwgqqVnN9USAdW9TA42gjvfGyLaBGgXVU+oaeIrc227LFBqhbz55
yhAQbl8FoviudRU5gtXkXZDu20bxuExo15zUaQQadK2noWSC1CKUMYVAoh0nq8HY57GGnxo6igUI
qSVQyRbClj333m3hhSdxrzs0L0UjkFYSFBScVAurxrGMIR7zQoaomRsabeJJ8+FzBs3v5QQ4uu21
UVtDTBhrow2se9seU9naOaDItQhBZol5C+MoM7sdDdTU435n0DKAWDHAGYKstygU5WaDm9GHhGt2
sBlY0G6/Y04QNMKjFr4EjMa7OFSY47/KOC1ynKO4rZJaQkrcTt8UVuV4CIKdZcPgq3a3zSwoBFvQ
fEHotYmERui2bBggDHruewhtI2Ry0W/bWQ/37m9/tcM7LX5AAovt0NjtJ73+uAXBlxES0nIQkymA
4L2WNTYOQ7RfDLfPeTxTuEvng0JQXT5pVIi+KmVHrMoYpkw4q1+qcOKmGno5H7SDUlU5f16Om5gx
XWdt+avHykUrj2X1KnOdlSUiQFxMQyuc0SiysBSgf5MobCxwfFZXLx0GkzYCzGsBOBa1U96sBkAI
cdzefd/5MN4c0gX8+2go2QCWQoKFZlHN+evx7XhKX0rl6WvgnCMncxKNQkHsB6UXzDAGYRi142T3
+vJWEI5mrNWopzcHgXzbXwVLw25eaZliWl4rP+xP+6f9tjRuY6HqODPv05xTjCy3dK5Lk1O9BS1U
efN8/DogQgsaGufFrFlWVtGQXUZqsZIGBenp3/3hpzqYb4hFQGSRn5TQGndqOcIzUr3molvAqyOz
P4GBfRpo9TIwJQ6qyTRgJzOyMrEvqM5LeZZAYCRMZ3cARt5c16tAwuLaqXnRmfuqqjbyidlfApru
myMjSzx0Qcu1xIZUOxyoLJpy2gacROZRUcQtkeRKXXIOZ9S2NDUusqxHwYglPqAZQeoCtR0u4yAg
5su9wAeJuUeRxY5cwPBxbvaYVgBMPaa+NBx8CSx57XLGh/L98IoPAho0vpHh0hwkjiLqWYoscx8F
ybDTdc1XST2CgW4jyPexxdxwc8gDob9vrjIuu+bKlI+42VirbfTUIaKZNAL/W6hewHIzlWtsw+Ne
KEf9ZX9wvq03B+e/5/Sc1m4MqIn1WYSVLOyLbAKbhXMg9T8ZhuUzacv/ZhNvZLncCT3V3fI2WBKZ
96MAg7uza7fGgO8ygg+WU8kpYhHyLLkPjWzneSbLCFOCLaaYVOorXsyY5XQiDLxa0eUqBY8x8unf
FqLBCjR2CEV4l55Kp6ElU1bXg+zY/vRDPUuBMM/tOCA3kN+xr5vTx4rrUm5Xvd0oHdIzWinmTxHn
K0aQeRtFHEyIWbHV6HMSeGGU9MDoWZQosNxoLPUWzJxNlVAihFHzbEeet5tX0JeXzfbN2eUSbvf8
mf31Le4ESffOkg6psxqzHE25LavWzkCYblBpya5f2IFGSxKBmDd0XVdtpBnuIS4JVlcmojG1eUPc
s91hQTyi2BKqj/p9Y3t24mOjCIvh/S8LJyeWAiMhPAptvCQ2wBjENrAYGCQFYeaKQEC6s/pNmAtw
CHElNt0mVgAZhtfwNG9QJaXyZhbNoOQQQy2okBYrUCAO3e69FUFVB8GIJhERFq8iqLi3MY5TbC37
xIFn1U5pexwypyiJ1AuUFqOtwt5WawUUFZaqJKEkoGY74Plds+smrq2wGYhhb2g5OAOPoR7RGGEr
4vvhYmwp/kVDd3BvkAwxux9CKF9OUBSf5sQPMZVm5yHpJAx677DJwCe6nJjDEtGlzcRG7n+mOydS
GYvBschmHKJy4216PDpKAD7s9rubH+uXw/p5s/9YN6UNt5sNsN45m+JOb2W2hUWkxp5n3owp5dxy
JdBmxDm31O5sHdRCbMU88IwWzYVe8Ek9AGsmn8ILwPnkpYPKzilIY4OA268/9rs306U9Pq29kMhm
2L2eT9ZTNhrw+JKwxsf0sFX1n8qOlDETFsaqejEvXU2otCdcoHhphQocERIkywd30Om046we1Plx
OR9SWH+Fq1oCXEOQwpwgZ1AyV7S/1DuRuanolnGOfglNR1QTxIi632bS7xBs5QWhdCinbtPVviZ0
2Ol3K/Va3Qx/66PXMLAcdvGda7HWGoWjaGa5AJYjYMqF6VFTBvbpCMBN4iK0sDCrUW6qsHlGVvqG
SunRbN4C4RRQWnncWkDA8dgWccHxZ++iLOW7KAFZSOOjj5KAlh+E6kdRVf5kjc17lzUEGNC2uRmC
KvdbLtzn82LX7dgu7Gcoc7FcLpHlEVChTEJSbPaWuTqFMZ5mGtmCpW7wNiQC/1gf1k9gSJpXNucl
rZjLJDeOpbcyi1JbRfiQr96BZfd9DXegRXrYrMtHytWuw+5tp6qAeWPLdBqsX6eY1aRACaIkRpEU
D33zEGQpITkhTZoD8JoKA1o08eY7wflQOIxIYwWqsclEVRK8HyZcrkoXF4ub8ZZGGCUO5EP39nJ1
E8J99WCmbDN9Xkxmcao2C61Kf80YgnJGq1UjRiHqCjzfUPhYrE9PP5733x11Qb60wQsk8dQLK68E
ijaQmAVahXEzyryMZi+Tq4dLl5EsydJjDIlUsvDMGq3Lp5ByTe0YPmXube+2FQFMvWtFEPi227FC
SRyFrQTQEeSyVugCjUlk76vOaSG+sdClnHgL2b/awIMODG0DYh7bGbYY9gbdu+m4DWF4d2eHq5j/
7zo0j9jQzdf1MX1uymIpQW+VGEaXOGQLs/E2zQl++v8xJ31nWhjZ9J4jFqN3BwecdwYHkx2BzloK
O8E8QqZr7pW3wfAFgnghw4m6WV6uqUlLMTbq3Q/MJQfEIei3lZlEGKx4kxHj7N4YpFTOt+3+9fVN
XyQrQufMp5ReG04qF/Phq1JTMzEKJltgzPLwLoPZlghQ/WbbwNcLLGF4WiczmFOPmuMCBRbU8lBQ
wfRzdCt43jKs6WV/sb/V38OAr4n0xuZCjQJGtkN6DUSe7fcDFJhNzCQqmG3lbIHmZl8HkbDhiVCh
Erx60qZfxSshp9GjBV0f/1XLrcFEv7lvPlPMDy+xIanr4kqO08UJVq/Sq2750h9tv+8Pm9OPl+r5
cFf9sIp6F2ix+zmcY/N9iCscGWedgo3Rb8PVA0bjwSvOrmn3zAcuF/jAfN32Ardc89Zw5t3dWs7G
MrCqpZoyAoBC5ubW2UyHrulujgYJVMcOdGHUcjIF8PwJ1XtwyNMm0xYsSpdmC6KhUSjQ3HavWWFk
YPMIuQNH2HJRQXVXV6Lv7XsI8IHlQnoOvh9YrjgrsIztU9vMUQ7jkeUYSIHD0AtDu+SAVNfr9Vp4
L1It0t1xfzhCFrR5NWooBO8QQ1cC66xFQMTI3E71AYYFx8zWCk7vnXHEyFryzVE84Q7eoWasDhot
l55ylIl/6w6FxSHnOFQOzb8lUyD47K59yYDw7giWC14XBNtFvCuCWS5KCO8R+e4yLXf/CwSGlu7A
NR8DFDiCCdy/Y+0bB2owGA5M504FBkTKd0PXM8kpgPy74a3lt8FKWDoWb+hKqIrX2hfUlKQxhD7u
aRcdcEPD2zuLlSrj3LczBPzz8NYScSmtzZ4Fq4z7HRTl+95BGVl+kqE0z5Q2Lyx56+12ffzP0XFv
/t2Aqfl6rhbO3UYPtjk+mSr6dMTAADR/jUBfD3xJnzdrQ+1GXexKsjKqRp5v/tfYlSy3zSPh+zyF
a+5T0W7qCG4SIm4hSFnKRaWxVY5r/FsuWz7k7acbICmC7KZ8iCtCf1gINIAG0MvT6XwXnj+M98Pa
Ztski6fj+6VzpDYluIUzo2eioWcx3TlV7odfnqA5wgC8W/SM2RwMWQkxn8wYJeU2hJ6D+JiXH6aj
KS1cVAUU+CYy9JVQxf14SjOjQcQ7evurRimj3yoMdR3sZBkf0lwy8rIFWwWxTOgzTNWjO8ch1hFD
TLcwHMjNNdfk+EhEsod+KDp4IMbTMo2h59B5zM1lG0ALVwYhfuOlyAAAPrkIhuowAPZt2IBgrZa8
zkmNCYAbhhAqHC9C5oG6jciHvrgI8lwUAc0UFSQvGTuZir7P1inDLwbxO42KXO76y9bL88vl+Fot
DO7H+fj0eNTqRbXzhDYX+LaNmXED8XF8//PySB4XwqF5oIKo45nEZD2DjPYKR/uXz3f0Q2CO+H1p
bbsS1AVx7AvqIrT+AFQEamWrTL6+3p5al7r4UlTPiMaTjHEiq6F34uPxz8vl9Ig+Glv5kpZJPPyo
/K9ZSZkX2wnrBz/I7CQ4vsbSl3aiCn6VQeJ1y4Nk8012cqoU+stq3UlDYix3sPwBqdekfmJTnSZZ
xcBeXH/YdZ+G9Eo91NxNb4i+R5DeQO3yzJ4aB3Ga7ykKrDjG/cy/2k5Hejug/sKsnI3G+sbf/hyi
i7Yy7/dyXGRi2+0JfZtfjhfz+aiD1tXVnIIHD2I3R6Dwx9y2imRPzSbcgaAmM8YJNZkxvgByAOcE
h68byA5nYYLvpaXyIqGUZJ7XDQQ13oOYlr0qCKy3LFm/ZbC3ORYCtmdGcwK5PivkcrK71d017Ea3
a9iUb7Vy+Srg+MaPiHLFA/+p+JVhnibM3TwOeCydKXM4Nw2PpkrwDKNWIhI7xggQ6crreHyor7vp
WSe85f0BfRR63SVBRHI+m/NdPGCofyVrjxXMMQNBpeNw7+0VmdEhqskDXQnCyHTK2R4BHcTle8pG
o5qXi93OXjFMGr5pw/ndulKsZ7JDXWzpiRqX49Fm3O3iTZqvxhPOgMus+oJTWQByEk+Yuza91sfB
wMoD1OVg3uVizude+5yNHm6d6AhoYA7s45CT7wzjqRmnVlZNoaHscOocT+/57IbO8zUsqsvp4Jq7
XPDkSuxkrjMAEMbOiGMT6QXj+/GkyyY6eUIZ7tTLa+TsRr1cVTo/+1SaSG8rXcYOw2y0wmGNGJG+
m9jmhfX7F73aAEG7hU/tmYXJpdpN9vV2nL6f3ipxTfXUuIwyUIb2EWTNPWETEtudg7XRNoF4qD+9
vh7fTuevT11Wz8rIZN7CkISWkjqmuyLxHyRnmqxz7hMRSw/mdZIyergIIzx6WvS0oJw76s7NvfVh
LdRh7bV0giwKWp416mnwievz5wXl9svH+fUVZPWephHmDiCTLrPTjzpdZZFEXWv6sNXA8jQtDuvS
PRSUipf+rmstrdTymto0utIu8F6Pn5+ULlnDaGyT3KgMCmjRGppDb6eIQimTJQqPnltIq5Q8mA9F
e1axCrq9WSUPOH1to/KHSry+ifRFIUJBy15tXJgHAffC28ZJ5XPK7Fa12UAH1aB1Blv86HQTp3w/
H9FXQ13YnL4rbsN0ZIOOfWzDXG3Fu848WMsOc0JCrfDZVARph5B+wquyUO+Gei5K/849Q2pjDsrw
Nqd5p3kWddV4ppVZ5wamRXwQMPxdrty4xQDvaFexsWC8P+v2aI03fm3QEi1L3nEqefpjClhW4PBJ
2Fvpgfzn+MxoXuuG+Z4zwMbafTd3W6UHMoO/pDE4Vk7e+Nq7gXARyBUPmwxz36ozK5d+HUKidOOh
vBvc+MUDfSzUC/F2PqYlJD2JgtlogJosvfGIFh3NFNwuHOpJVzPgEoQrL2wv9bXh3BEvNs/9qeCJ
gv+QDZzWBvbjDJiP8+KM9LyInPGcZxH4RxmGYbO1ziEze0ul7u1zTZOtUreE/RgyXqirMzMCeK9h
r0TVXcfViV5nzDTVDaINY1vRQvlyhf57vCDqKWRTcG+f5RgZKKbF4hYyiKHHb4HCwgeZYmDrrnBb
ybnnboFkxoRJaWNulhL4q2/1RI07MKpJVsNo72ktyCbYq0wkh4yxoexDb8IixodjG5O6MkIr41vA
GEMzdS63+qgsmkxH056kY4hKhPy+0XCXG+Q/uZeJFnAn80HhxaDSOJHcnLXlf2byBrFc8KsbUCf0
sRqphVzRSuxGXg1y9SAYX1R6OZLpfGDDioJVWuB2zCM8vvCIMWvWa+wejVgHpN01mpgXG0axqQWB
UdjyM7sIFD0yooh/+CpqjUlDWh2fnk8XynoHS1wJrLVXZohuto2FkBWWrZgc7HNdlXTYoeM1gtOB
PjVZ7ASToVOSJphga8KjGaFGqcAr847pWgX5aZt1wE/W3z8UFLvaYW87Rx5IGIYZUIkshhiqTj80
yVp1jmx6A9FOBWUSMo9v1wr6vXr9Kg0gSTuehO+pO46YpzGf81eZFpTOhp+khQz3VlyLskj5ggy1
27mGLY+Pf2wpMFS0N2XjmOiHv/U1p/YYFXa+5WIxwjFqZICfaSRt7cjfACPHuPRDKyv+TqLGC6Sf
qh+hKH4kBV070KzssYIcVsq2C8HffhCKMir0bXOGp19nMaLoMkXVSgyu8u+Xz7PjzJf/Gc9b3q2T
otf75o778/T1dNYe9HtNvvq5bCdsOrYfe2UzPRzT+IEGYlbQXFwhijizy9MJA0y/LmGtilymwop6
yDqqhTV7ozfwegjtnczukiur+gNsHPK09SApi0qW7AZ8VpcnDeTy9GeTpO3AQrHOBpaCZDfjqRg+
k6OVNGPWJxi96aj+OCR8bUCid+Vgh3Im18bYZftLcjV5GZsn9QXPJ/RcPH5cXrQvm+Lvu73mZSIv
0Fdi0nhBIpjZLCkNtPH/dLzA/n8XHd+ev47Pp37AIlzF/mn9qBcVeylp0evF6DCb3reFVIt2P6WV
C22QrUdJQZz5iK3DYV5bOiD6aqsDur/ZkMVAQxb02b4D+k5rGT3yDohWxuqAvvPdjAPoDoi+Q7RA
S+ZJ3gYx9wKdkr7RT0tG5c1uOKOJiSDY55G3D/T52ypmPPlOswHFM4FQnqRMN9stGXfZqybw3VEj
eJ6pEbc7gueWGsEPcI3gp3yN4Eet6YbbHzOm3vUswLzbl5tUOgfGL0JNLplSyyJ0Wj4HQTKwfe5d
l+k8DWVEubTemFjcf46P/zOOrBqBCDV+mkDV9Uou0M0q7Jp2iAXtRksVgtF0NmWpSFBu0Q2xF0fy
QWyCMkPFLWh1P1QkKi9axyAPzlcSo0U2CJ2TETMqLIahTMOQwFZIDNCZePtrM5oyGgo2hBLgChP8
BMN9N3pTnR6pQmIP9BkR6rGD6J7MmtMyPgCJOIATqjFQbrqQSQ5EHu0rlbFrajV0hfA26RYOelH6
YHkh0EGzBkcds0JzOAuaaviBLKKICUc22+hSqMMPxqgLJT5/x1nl6PPaeB2UM8vw+GE1euX3dSfV
6dEEeT/3vZPifRxRd32qt43iTRr6NEFbwIFsB09kwoVZWchA2eYDFQDfWDHMGC0W1ij4T7SljByv
5UDfoqIgWYkKYF0o++qo3sff98v52aiUUr1iQiz18kUv//04fvy9+zh/XV7eTp0s3sHzJPlkDLSp
pSwRSVeneQS49vXdjyVbUyC1iejWYgcrvi4mrAv7Nwbdgw6zA2Pq8LIwbbLUDmakw4D/H2Ea8mAK
gQAA
------=_20041115223554_53502--


