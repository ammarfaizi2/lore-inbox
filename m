Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135868AbRDTLTy>; Fri, 20 Apr 2001 07:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135869AbRDTLTk>; Fri, 20 Apr 2001 07:19:40 -0400
Received: from [202.54.26.202] ([202.54.26.202]:10440 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S135868AbRDTLTN>;
	Fri, 20 Apr 2001 07:19:13 -0400
X-Lotus-FromDomain: HSS
From: npunmia@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A34.003CDC69.00@sandesh.hss.hns.com>
Date: Fri, 20 Apr 2001 16:48:46 +0530
Subject: RTC !
Mime-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=EfR7i37cNW39tMKovOZBU3NLTfszJjXapJ7cAbT37vEE57KoQuJUqtcj"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=EfR7i37cNW39tMKovOZBU3NLTfszJjXapJ7cAbT37vEE57KoQuJUqtcj
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline




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


---------------------- Forwarded by Niraj Punmia/HSS on 04/20/2001 04:31 PM
---------------------------


Niraj Punmia
04/12/2001 02:50 PM

To:   linux-kernel@vger.kernel.org
cc:

Subject:  RTC !!

Hi ,

The RTC interrupt  is programmable from 2 Hz to 8192 Hz, in powers of 2. So the
interrupts that you
could get are one of the following:      0.122ms, .244ms, .488ms, .977ms,
1.953ms, 3.906ms, 7.813ms, and so on.    Is there any  workaround , so that i
can use RTC
for meeting my requirement of an interrupt every 1.666..ms!!  ( I know that i
can use UTIME or #define HZ 600, but i want to know if i can use RTC for this
purpose )

With Regards,
--Niraj

---------------------- Forwarded by Niraj Punmia/HSS on 04/12/2001 02:33 PM
---------------------------


James Stevenson <mistral@stev.org> on 04/09/2001 06:42:44 PM

Please respond to mistral@stev.org

To:   Niraj Punmia/HSS@HSS
cc:

Subject:  Re: 1.6666.... ms interrupts needed!!





Hi

instead of modifing the time irq freq you could try using the
realt time clock (rtc) it will generate irqs with better timing
and you also wont hit system performance as much by modifing the timer
ever time the timer send an irq some code is run to see it schedule need
to be called the more times schedule is called a second the worse the
system performance is because of the task switching overhead.

In local.linux-kernel-list, you wrote:
>
>
>
>Hi.
>
>We are simulating air interface of GPRS on LAN. A TDMA(time division multiple
>access) frame duration is 40ms.  Each TDMA frame consists of 24 timeslots. Each
>timeslot  is  of 40/24 ms (i.e 1.66666.......ms) . To know  what current
>timeslot it is, we need a timer interrupt after every 1.6666... ms .   Since we
>are implementing this on LAN, minor jitters once in a while can be tolerated
>(say 0.2 ms more or less once a while would be OK).
>     As of now, we are modifying the HZ value in param.h to 600.  This gives us
>a CPU tick of  1.6666.... ms. (i.e 1/600sec).  I want to know if it would
affect
>the perfomance of the CPU.
>     Is there a better way to achieve the granularity of 1.666...ms .  Would
the
>UTIME patch be a better way from performance or any other point of view  than
>this method?
>
>With Regards,
>Niraj Punmia
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


--
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  1:10pm  up 13 days, 21:05,  5 users,  load average: 0.45, 0.45, 0.47






--0__=EfR7i37cNW39tMKovOZBU3NLTfszJjXapJ7cAbT37vEE57KoQuJUqtcj
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

--0__=EfR7i37cNW39tMKovOZBU3NLTfszJjXapJ7cAbT37vEE57KoQuJUqtcj--

