Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbRDUKwx>; Sat, 21 Apr 2001 06:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDUKwo>; Sat, 21 Apr 2001 06:52:44 -0400
Received: from [202.54.26.202] ([202.54.26.202]:27267 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132558AbRDUKw3>;
	Sat, 21 Apr 2001 06:52:29 -0400
X-Lotus-FromDomain: HSS
From: npunmia@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A35.003A691A.00@sandesh.hss.hns.com>
Date: Sat, 21 Apr 2001 16:19:08 +0530
Subject: Re: RTC !
Mime-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=loHbN4NM4sLjztC0CyWarhMNvXTAK5cVHpH075HhC91GXtHU3UN5vu8Z"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=loHbN4NM4sLjztC0CyWarhMNvXTAK5cVHpH075HhC91GXtHU3UN5vu8Z
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Can someone help me with this !!!

With Regards,
--Niraj



Niraj Punmia
04/21/2001 03:42 PM

To:   Jesper Juhl <juhl@eisenstein.dk>
cc:

Subject:  Re: RTC !  (Document link not converted)

The version of gcc , i am using is also egcs-2.91.66 !! How come i am getting
this problem???



Jesper Juhl <juhl@eisenstein.dk> on 04/20/2001 07:34:47 PM

To:   Niraj Punmia/HSS@HSS
cc:

Subject:  Re: RTC !




npunmia@hss.hns.com wrote:

> I am using Linux 2.2.18 with KURT patch installed! I don't know which gcc/
egcs
> i am using ? How do we check it?

gcc --version

/Jesper Juhl




---------------------- Forwarded by Niraj Punmia/HSS on 04/21/2001 04:10 PM
---------------------------


Niraj Punmia
04/20/2001 05:29 PM

To:   Jesper Juhl <juhl@eisenstein.dk>
cc:

Subject:  Re: RTC !  (Document link not converted)

I am using Linux 2.2.18 with KURT patch installed! I don't know which gcc/ egcs
i am using ? How do we check it?

--Regards,
--Niraj



Jesper Juhl <juhl@eisenstein.dk> on 04/20/2001 06:08:57 PM

To:   Niraj Punmia/HSS@HSS
cc:   linux-kernel@vger.kernel.org

Subject:  Re: RTC !




npunmia@hss.hns.com wrote:

> Hi,
>
> When i compiled the following program , (taken from
> /usr/src/linux/Documentation/rtc.txt )
>
> (See attached file: rtc2.c)
>
> it gave me the following error:
>
> [root@msatuts1 timer1]#  gcc -s -Wall -Wstrict-prototypes rtc2.c -o rtc2
> In file included from rtc2.c:17:
> /usr/include/linux/mc146818rtc.h:29: parse error before `rtc_lock'
> /usr/include/linux/mc146818rtc.h:29: warning: data definition has no type or
> storage class
> rtc2.c:25: warning: return type of `main' is not `int'
> [root@msatuts1 timer1]#
>
>  Is this a bug?Can anyone tell me how to remove this parse error ?

It works fine for me using a 2.2.16 kernel and egcs-2.91.66 (see below)...


bash-2.04$ gcc -s -Wall -Wstrict-prototypes rtc2.c -o rtc2
rtc2.c:24: warning: return type of `main' is not `int'
bash-2.04$ ./rtc2

                        RTC Driver Test Example.

Counting 5 update (1/sec) interrupts from reading /dev/rtc: 1 2 3 4 5
Again, from using select(2) on /dev/rtc: 1 2 3 4 5

Current RTC date/time is 20-4-2001, 12:34:01.
Alarm time now set to 12:34:06.
Waiting 5 seconds for alarm... okay. Alarm rang.

Periodic IRQ rate was 1024Hz.
Counting 20 interrupts at:
2Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

                         *** Test complete ***

Typing "cat /proc/interrupts" will show 131 more events on IRQ 8.

bash-2.04$


Regards,
Jesper Juhl
juhl@eisenstein.dk



To:   linux-kernel@vger.kernel.org
cc:

Subject:  RTC !


Hi,

When i compiled the following program , (taken from
/usr/src/linux/Documentation/rtc.txt )


(See attached file: rtc2.c)

it gave me the following error:

[root@msatuts1 timer1]#  gcc -s -Wall -Wstrict-prototypes rtc2.c -o rtc2
In file included from rtc2.c:17:
/usr/include/linux/mc146818rtc.h:29: parse error before `rtc_lock'
/usr/include/linux/mc146818rtc.h:29: warning: data definition has no type or
storage class
rtc2.c:25: warning: return type of `main' is not `int'
[root@msatuts1 timer1]#

 Is this a bug?Can anyone tell me how to remove this parse error ?

With Regards,
--Niraj





--0__=loHbN4NM4sLjztC0CyWarhMNvXTAK5cVHpH075HhC91GXtHU3UN5vu8Z
Content-type: application/octet-stream;
	name="rtc2.c"
Content-Disposition: attachment; filename="rtc2.c"
Content-transfer-encoding: base64

DQovKg0KICoJUmVhbCBUaW1lIENsb2NrIERyaXZlciBUZXN0L0V4YW1wbGUgUHJvZ3JhbQ0KICoN
CiAqCUNvbXBpbGUgd2l0aDoNCiAqCQlnY2MgLXMgLVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyBy
dGN0ZXN0LmMgLW8gcnRjdGVzdA0KICoNCiAqCUNvcHlyaWdodCAoQykgMTk5NiwgUGF1bCBHb3J0
bWFrZXIuDQogKg0KICoJUmVsZWFzZWQgdW5kZXIgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlLCB2ZXJzaW9uIDIsDQogKglpbmNsdWRlZCBoZXJlaW4gYnkgcmVmZXJlbmNlLg0KICoNCiAq
Lw0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxsaW51eC9tYzE0NjgxOHJ0Yy5oPg0K
I2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KI2luY2x1ZGUgPHN5cy90aW1lLmg+DQojaW5jbHVkZSA8
c3lzL3R5cGVzLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4NCiNp
bmNsdWRlIDxlcnJuby5oPg0KDQp2b2lkIG1haW4odm9pZCkgew0KDQppbnQgaSwgZmQsIHJldHZh
bCwgaXJxY291bnQgPSAwOw0KdW5zaWduZWQgbG9uZyB0bXAsIGRhdGE7DQpzdHJ1Y3QgcnRjX3Rp
bWUgcnRjX3RtOw0KDQpmZCA9IG9wZW4gKCIvZGV2L3J0YyIsIE9fUkRPTkxZKTsNCg0KaWYgKGZk
ID09ICAtMSkgew0KCXBlcnJvcigiL2Rldi9ydGMiKTsNCglleGl0KGVycm5vKTsNCn0NCg0KZnBy
aW50ZihzdGRlcnIsICJcblx0XHRcdFJUQyBEcml2ZXIgVGVzdCBFeGFtcGxlLlxuXG4iKTsNCg0K
LyogVHVybiBvbiB1cGRhdGUgaW50ZXJydXB0cyAob25lIHBlciBzZWNvbmQpICovDQpyZXR2YWwg
PSBpb2N0bChmZCwgUlRDX1VJRV9PTiwgMCk7DQppZiAocmV0dmFsID09IC0xKSB7DQoJcGVycm9y
KCJpb2N0bCIpOw0KCWV4aXQoZXJybm8pOw0KfQ0KDQpmcHJpbnRmKHN0ZGVyciwgIkNvdW50aW5n
IDUgdXBkYXRlICgxL3NlYykgaW50ZXJydXB0cyBmcm9tIHJlYWRpbmcgL2Rldi9ydGM6Iik7DQpm
Zmx1c2goc3RkZXJyKTsNCmZvciAoaT0xOyBpPDY7IGkrKykgew0KCS8qIFRoaXMgcmVhZCB3aWxs
IGJsb2NrICovDQoJcmV0dmFsID0gcmVhZChmZCwgJmRhdGEsIHNpemVvZih1bnNpZ25lZCBsb25n
KSk7DQoJaWYgKHJldHZhbCA9PSAtMSkgew0KCQlwZXJyb3IoInJlYWQiKTsNCgkJZXhpdChlcnJu
byk7DQoJfQ0KCWZwcmludGYoc3RkZXJyLCAiICVkIixpKTsNCglmZmx1c2goc3RkZXJyKTsNCglp
cnFjb3VudCsrOw0KfQ0KDQpmcHJpbnRmKHN0ZGVyciwgIlxuQWdhaW4sIGZyb20gdXNpbmcgc2Vs
ZWN0KDIpIG9uIC9kZXYvcnRjOiIpOw0KZmZsdXNoKHN0ZGVycik7DQpmb3IgKGk9MTsgaTw2OyBp
KyspIHsNCglzdHJ1Y3QgdGltZXZhbCB0diA9IHs1LCAwfTsJLyogNSBzZWNvbmQgdGltZW91dCBv
biBzZWxlY3QgKi8NCglmZF9zZXQgcmVhZGZkczsNCg0KCUZEX1pFUk8oJnJlYWRmZHMpOw0KCUZE
X1NFVChmZCwgJnJlYWRmZHMpOw0KCS8qIFRoZSBzZWxlY3Qgd2lsbCB3YWl0IHVudGlsIGFuIFJU
QyBpbnRlcnJ1cHQgaGFwcGVucy4gKi8NCglyZXR2YWwgPSBzZWxlY3QoZmQrMSwgJnJlYWRmZHMs
IE5VTEwsIE5VTEwsICZ0dik7DQoJaWYgKHJldHZhbCA9PSAtMSkgew0KCQlwZXJyb3IoInNlbGVj
dCIpOw0KCQlleGl0KGVycm5vKTsNCgl9DQoJLyogVGhpcyByZWFkIHdvbid0IGJsb2NrIHVubGlr
ZSB0aGUgc2VsZWN0LWxlc3MgY2FzZSBhYm92ZS4gKi8NCglyZXR2YWwgPSByZWFkKGZkLCAmZGF0
YSwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsNCglpZiAocmV0dmFsID09IC0xKSB7DQoJCXBlcnJv
cigicmVhZCIpOw0KCQlleGl0KGVycm5vKTsNCgl9DQoJZnByaW50ZihzdGRlcnIsICIgJWQiLGkp
Ow0KCWZmbHVzaChzdGRlcnIpOw0KCWlycWNvdW50Kys7DQp9DQoNCi8qIFR1cm4gb2ZmIHVwZGF0
ZSBpbnRlcnJ1cHRzICovDQpyZXR2YWwgPSBpb2N0bChmZCwgUlRDX1VJRV9PRkYsIDApOw0KaWYg
KHJldHZhbCA9PSAtMSkgew0KCXBlcnJvcigiaW9jdGwiKTsNCglleGl0KGVycm5vKTsNCn0NCg0K
LyogUmVhZCB0aGUgUlRDIHRpbWUvZGF0ZSAqLw0KcmV0dmFsID0gaW9jdGwoZmQsIFJUQ19SRF9U
SU1FLCAmcnRjX3RtKTsNCmlmIChyZXR2YWwgPT0gLTEpIHsNCglwZXJyb3IoImlvY3RsIik7DQoJ
ZXhpdChlcnJubyk7DQp9DQoNCmZwcmludGYoc3RkZXJyLCAiXG5cbkN1cnJlbnQgUlRDIGRhdGUv
dGltZSBpcyAlZC0lZC0lZCwgJTAyZDolMDJkOiUwMmQuXG4iLA0KCXJ0Y190bS50bV9tZGF5LCBy
dGNfdG0udG1fbW9uICsgMSwgcnRjX3RtLnRtX3llYXIgKyAxOTAwLA0KCXJ0Y190bS50bV9ob3Vy
LCBydGNfdG0udG1fbWluLCBydGNfdG0udG1fc2VjKTsNCg0KLyogU2V0IHRoZSBhbGFybSB0byA1
IHNlYyBpbiB0aGUgZnV0dXJlLCBhbmQgY2hlY2sgZm9yIHJvbGxvdmVyICovDQpydGNfdG0udG1f
c2VjICs9IDU7DQppZiAocnRjX3RtLnRtX3NlYyA+PSA2MCkgew0KCXJ0Y190bS50bV9zZWMgJT0g
NjA7DQoJcnRjX3RtLnRtX21pbisrOw0KfQ0KaWYgIChydGNfdG0udG1fbWluID09IDYwKSB7DQoJ
cnRjX3RtLnRtX21pbiA9IDA7DQoJcnRjX3RtLnRtX2hvdXIrKzsNCn0NCmlmICAocnRjX3RtLnRt
X2hvdXIgPT0gMjQpDQoJcnRjX3RtLnRtX2hvdXIgPSAwOw0KDQpyZXR2YWwgPSBpb2N0bChmZCwg
UlRDX0FMTV9TRVQsICZydGNfdG0pOw0KaWYgKHJldHZhbCA9PSAtMSkgew0KCXBlcnJvcigiaW9j
dGwiKTsNCglleGl0KGVycm5vKTsNCn0NCg0KLyogUmVhZCB0aGUgY3VycmVudCBhbGFybSBzZXR0
aW5ncyAqLw0KcmV0dmFsID0gaW9jdGwoZmQsIFJUQ19BTE1fUkVBRCwgJnJ0Y190bSk7DQppZiAo
cmV0dmFsID09IC0xKSB7DQoJcGVycm9yKCJpb2N0bCIpOw0KCWV4aXQoZXJybm8pOw0KfQ0KDQpm
cHJpbnRmKHN0ZGVyciwgIkFsYXJtIHRpbWUgbm93IHNldCB0byAlMDJkOiUwMmQ6JTAyZC5cbiIs
DQoJcnRjX3RtLnRtX2hvdXIsIHJ0Y190bS50bV9taW4sIHJ0Y190bS50bV9zZWMpOw0KDQovKiBF
bmFibGUgYWxhcm0gaW50ZXJydXB0cyAqLw0KcmV0dmFsID0gaW9jdGwoZmQsIFJUQ19BSUVfT04s
IDApOw0KaWYgKHJldHZhbCA9PSAtMSkgew0KCXBlcnJvcigiaW9jdGwiKTsNCglleGl0KGVycm5v
KTsNCn0NCg0KZnByaW50ZihzdGRlcnIsICJXYWl0aW5nIDUgc2Vjb25kcyBmb3IgYWxhcm0uLi4i
KTsNCmZmbHVzaChzdGRlcnIpOw0KLyogVGhpcyBibG9ja3MgdW50aWwgdGhlIGFsYXJtIHJpbmcg
Y2F1c2VzIGFuIGludGVycnVwdCAqLw0KcmV0dmFsID0gcmVhZChmZCwgJmRhdGEsIHNpemVvZih1
bnNpZ25lZCBsb25nKSk7DQppZiAocmV0dmFsID09IC0xKSB7DQoJcGVycm9yKCJyZWFkIik7DQoJ
ZXhpdChlcnJubyk7DQp9DQppcnFjb3VudCsrOw0KZnByaW50ZihzdGRlcnIsICIgb2theS4gQWxh
cm0gcmFuZy5cbiIpOw0KDQovKiBEaXNhYmxlIGFsYXJtIGludGVycnVwdHMgKi8NCnJldHZhbCA9
IGlvY3RsKGZkLCBSVENfQUlFX09GRiwgMCk7DQppZiAocmV0dmFsID09IC0xKSB7DQoJcGVycm9y
KCJpb2N0bCIpOw0KCWV4aXQoZXJybm8pOw0KfQ0KDQovKiBSZWFkIHBlcmlvZGljIElSUSByYXRl
ICovDQpyZXR2YWwgPSBpb2N0bChmZCwgUlRDX0lSUVBfUkVBRCwgJnRtcCk7DQppZiAocmV0dmFs
ID09IC0xKSB7DQoJcGVycm9yKCJpb2N0bCIpOw0KCWV4aXQoZXJybm8pOw0KfQ0KZnByaW50Zihz
dGRlcnIsICJcblBlcmlvZGljIElSUSByYXRlIHdhcyAlbGRIei5cbiIsIHRtcCk7DQoNCmZwcmlu
dGYoc3RkZXJyLCAiQ291bnRpbmcgMjAgaW50ZXJydXB0cyBhdDoiKTsNCmZmbHVzaChzdGRlcnIp
Ow0KDQovKiBUaGUgZnJlcXVlbmNpZXMgMTI4SHosIDI1Nkh6LCAuLi4gODE5Mkh6IGFyZSBvbmx5
IGFsbG93ZWQgZm9yIHJvb3QuICovDQpmb3IgKHRtcD0yOyB0bXA8PTY0OyB0bXAqPTIpIHsNCg0K
CXJldHZhbCA9IGlvY3RsKGZkLCBSVENfSVJRUF9TRVQsIHRtcCk7DQoJaWYgKHJldHZhbCA9PSAt
MSkgew0KCQlwZXJyb3IoImlvY3RsIik7DQoJCWV4aXQoZXJybm8pOw0KCX0NCg0KCWZwcmludGYo
c3RkZXJyLCAiXG4lbGRIejpcdCIsIHRtcCk7DQoJZmZsdXNoKHN0ZGVycik7DQoNCgkvKiBFbmFi
bGUgcGVyaW9kaWMgaW50ZXJydXB0cyAqLw0KCXJldHZhbCA9IGlvY3RsKGZkLCBSVENfUElFX09O
LCAwKTsNCglpZiAocmV0dmFsID09IC0xKSB7DQoJCXBlcnJvcigiaW9jdGwiKTsNCgkJZXhpdChl
cnJubyk7DQoJfQ0KDQoJZm9yIChpPTE7IGk8MjE7IGkrKykgew0KCQkvKiBUaGlzIGJsb2NrcyAq
Lw0KCQlyZXR2YWwgPSByZWFkKGZkLCAmZGF0YSwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsNCgkJ
aWYgKHJldHZhbCA9PSAtMSkgew0KCQkJcGVycm9yKCJyZWFkIik7DQoJCQlleGl0KGVycm5vKTsN
CgkJfQ0KCQlmcHJpbnRmKHN0ZGVyciwgIiAlZCIsaSk7DQoJCWZmbHVzaChzdGRlcnIpOw0KCQlp
cnFjb3VudCsrOw0KCX0NCg0KCS8qIERpc2FibGUgcGVyaW9kaWMgaW50ZXJydXB0cyAqLw0KCXJl
dHZhbCA9IGlvY3RsKGZkLCBSVENfUElFX09GRiwgMCk7DQoJaWYgKHJldHZhbCA9PSAtMSkgew0K
CQlwZXJyb3IoImlvY3RsIik7DQoJCWV4aXQoZXJybm8pOw0KCX0NCn0NCg0KZnByaW50ZihzdGRl
cnIsICJcblxuXHRcdFx0ICoqKiBUZXN0IGNvbXBsZXRlICoqKlxuIik7DQpmcHJpbnRmKHN0ZGVy
ciwgIlxuVHlwaW5nIFwiY2F0IC9wcm9jL2ludGVycnVwdHNcIiB3aWxsIHNob3cgJWQgbW9yZSBl
dmVudHMgb24gSVJRIDguXG5cbiIsDQoJCQkJCQkJCSBpcnFjb3VudCk7DQoNCmNsb3NlKGZkKTsN
Cg0KfSAvKiBlbmQgbWFpbiAqLw0K

--0__=loHbN4NM4sLjztC0CyWarhMNvXTAK5cVHpH075HhC91GXtHU3UN5vu8Z--

