Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTAQRDv>; Fri, 17 Jan 2003 12:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAQRDv>; Fri, 17 Jan 2003 12:03:51 -0500
Received: from smtp-3.hut.fi ([130.233.228.93]:34499 "EHLO smtp-3.hut.fi")
	by vger.kernel.org with ESMTP id <S267611AbTAQRDs>;
	Fri, 17 Jan 2003 12:03:48 -0500
Date: Fri, 17 Jan 2003 19:12:43 +0200 (EET)
From: =?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?= <kmalkki@cc.hut.fi>
X-X-Sender: kmalkki@kosh.hut.fi
To: linux-kernel@vger.kernel.org
cc: LM_Sensors Development Group <sensors@stimpy.netroedge.com>
Subject: i2c and sensors for 2.4/2.5
Message-ID: <Pine.OSF.4.50.0301171830420.22376-101000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1273997454-1042823563=:22376"
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (smtp-3.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1273997454-1042823563=:22376
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Finally, i2c CVS is synced with 2.5.58 tree.

I believe we are ready to submit patches to both 2.4 and 2.5 trees
in a week or so. In the mean time, please hold any non-critical i2c
patches. Most of the 2.4 cleanup done in CVS already applies these.
And some of the header file cleanups applied in 2.5.53+ evidently
break i2c-proc and userland compiles for /dev/i2c-x ...

You can checkout i2c with "-r lk2-4" to get i2c code for 2.4 tree.
Attached is non-CVS i2c code ported back from 2.5 to 2.4.21-pre3
for the impatient, to use .owner refcounting.

As for lm_sensors, CVS head will work for both 2.5 and 2.4 after i2c
patches. Currently CVS compiles but all of PCI probing takes time to
convert. Post to LKML with a list of i2c busses you volunteer to fix.

Also, assistance on how to fix module refcounting is welcome.
To my understanding, it does not handle client->adapter->owner
correctly now, and it is possible to rmmod adapter while one of its
clients is in use.

HTH.

-- 
  Kyösti Mälkki
  kmalkki@cc.hut.fi

--0-1273997454-1042823563=:22376
Content-Type: APPLICATION/octet-stream; name="patch-2.4.21-pre3-pre4-i2c-1.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.50.0301171912430.22376@kosh.hut.fi>
Content-Description: 
Content-Disposition: attachment; filename="patch-2.4.21-pre3-pre4-i2c-1.gz"

H4sICDykJT4AA3BhdGNoLTIuNC4yMS1wcmUzLXByZTQtaTJjLTEA1Vttb9s4
Ev4s/wrCxRZJLCWSbMexc8k1jZPWe3k5NE527w4HQZZoW1tLMiQ52eLQ/vbj
kJREvTmSG+BwbhPJw+GQHM48HJKTe2/1DTkeWjne5k9FP+wd6pqyDnBvhC6/
XI0n04fDAP/Rsp35HCmboMDXPbID5xkH4ZGjW/CjmLa5VpwIH1pFoVuYW4qi
NJIuTTcY/bpZITREenekkv8DpKuq3up0Oo2aln7DNvrV9JDWR9pw1D0Z9XWQ
1G19+IAU7WQg9weoA0/9GH340ELfW4j8U8LIjByLaC9CjmMZRJYR4MVeGAUb
i5B0y7BWDialB+y531L+01KkAEebwEPqaUv53lLgX4mgjfdTop59x05kOZ5l
bEIsSoPBRzhAB/DChL1z5jaeo9v78ePNFZFNXozJ3aXx+HBlXN4/3k1JI++w
Ryxha2M23rWx8dW2xtDRAVLe6NNC6ABdeZa5DjcrM8IoWmJkzvxnjOYbz4oc
3wvBKYBs+UGAyUD8NQ5MVsKGtgnwIRU0XTqEO0Q+uJLtexi9LLGHXD8AwcSs
gLQ0A/vFJJRYGaRCuFmv/SDCNpVz1EJcn6LqVgvfANXaZmSmOoYvZwgs4O7x
5kYmz7goxBF5FSmLMor/4uUo1sq3voq0F9OJ5n6wdijniSoj+NFUVZakowMJ
ikMZRY6L/U0E3e9Ih6x1STpD+f6QwkWhcJEpJH3KFdJeskLavWwp7zEpT7sq
cIj97yDpcGPjlfkNWiDjgFpunsDHQgif/0mc/BS8vGRK4gnk7fjrkM9FezK9
QpPJZTzHbVDcRL80Pv9mTAxSIAsT9l6cTFHv3FtFEvcpkUTQQfxK4YIOgugM
BzCo6efJg8EcjBZ4pouBXtJLUurYUJbtLCFT+4MeksJcj7mCiFtemqsVQVBq
9eAyrm9vVhgsfOWbNjFvxHwk9i1QahCFwNu6r1p/RLweoSxg/2iyHn3F315w
GNVajhLemqtRwi9dBw4aYwuhY6Rrox5ZjPpNFqNUUHEtGqRrUU/TZY2sRfBk
S5GE2Adm7vqRwPXD7cfHB+Pjzf3l34zxxfTilC1XIla34ubA1iqBmrzwVaZs
Jfiew/9UJjHWmjLzgP+d29O1HyDPf5HRC2agSkDUXgEUuzPHI/ohBobRXujO
NuH+FuAMnGjporhfKQW8FbTZ76qypqFOXxvKmsrUKYXrgKzD8z2LNKqc805T
55FR+5cQ/WK3ZeStlfM1QXMvUs5ZkbN/CrVZLWduWpg0Q58CHX4bng8lp8S7
pGwb1HNRxnGFujEXWWqZn17cfLpns13CBYMlfO8Lg6/gjZcUQCcyE4VGGSYR
BsFySvg4UAl8hFLSJAtiAMScMKKDZg1XMVJ4e4WVjwCIp01gJXG9WqjiYtsx
j54dG/tHsyh6Vpz5VmQp5X8FXUrrlCBMrXC3XFgRZYZCxDvsyaSgA0+OMjzQ
BD/DJYiCQHLNOLMWnDCB9WLJaiwR4mozikxrSbpIQgJ3W1zNsUEf6IAJHf24
Kw9Z0P9KPMBUwAlGhN01DS0BbDoS9e2RBGidWZeRBPAxQplPexad9E7aUOrY
uTIUr9EfjY9TwkWDAKZ3kVOcD2DhmiywJJEFknI+CawZpQk8qTuOkI2zPN/r
OJ9glCOUWGVjB3TDdbenqrUdMOFv4IBJnRIHPGnqgKmwnAMOR6omOKCudWVt
SDwQXnS2NAnGTMQYZDF0ybJYbcoy2nihs4D1EupYri0z1zowg8V+hTGzTiP+
oGFtbC95Q20TfsQHxCtAwBsX5y0XzHb8ZfJ09WUyNm4f/g7VBPb5ylyEoxz7
tXF3P51c/0Pg4ybJnW5EVbEO/BkWeLhJMjUQmcDDaAIT11/SpKDTNI5O+5OP
p2M6jQyQyFeul7QCmQGUqVCumbQCVU2hQqqblDOrHMIpaCflyqgHca5YPykb
V0babEZDlXDIxXKkEGCwRfdIsRW194h14mif7pHiyYeBXd5Mru6mJLq5uf8N
EF2cV6rMEXrPXpJdDVN7KpCQuc7OKkQKyogtPRGaHVnsbky1lSuRzBYZ2yYC
GsJfggmN4S+yzUGvq9eGv4S/Afwldd4C/lJhRfjrCrucYxn2OMc8+HhH1rEV
2b2jv9BWjsKVOTtcnhcLaCM2fi4tJFMGdKWErkAErMyciFYUqrZhaTpctkWS
ubEd31o6a6DTXYSuynqP7SJ0LRMuqXGo1BBqKYRwZQnQKmWQYjq+gHLBP/KY
KXERBYCM6QVQjAu2AGFtJIyhsDAOetqQwcA8CCZDqwTBEhSU8vBHeHIKqMRA
gfVVIBR4d0fDVma6E+iCkzW60MKuNilXNGGK1Ip3fq4Uf+VwVpweMiu8+2Wr
0hltjOiygIuoBBhjPTieE+1BbLHfFPwSRNgF/IYng34T8GP8zcCP1Xkj8OPC
CuCn91Pw6w4Hsq6jDn2yyK9xqBb7HbRXEprlfQ3YZDh4+YQj5OEXemBNwnnE
yzLGWAYywFQGMpReBjK04O2ircJQ60Zb8eCbRFsFnDlDORVsCbXyStkSbhXU
9H8EMhxloP+ls8FhJtUTM+LtYViskJ9CG+aCzdFm48FpVF1XZ9xNkIbVeBOc
4aKKKHOSoszwGI52OvAYUIx5u9s1eiBbD7DSc5HsoUj8Kd1yTp8QHWLq7Un5
1j3n9PHu6ovA/MqOk2pp0IVIdDiItQQ2uaP/lWx8OsUyNrKEA72yNUo6X9ga
7XAOww2nuW8805i4vnfE/E38I67zJh6SCCv4SFdNfUTvw+ST3/+TbUiBwaso
CN21ATehbPNCj4/6vS54N3nq3HCbeySq55KovcCkAkA08U2q1xqOmfPMp4vH
8eR+i2/mnbOpZccTvoNtu86fTZA/5m9k27zO29h2LKxo2+IJ47Avn8AJfz8x
EIgKwI7oeSwo18WuH3xDL0tnxTIkqGS41iWFcMtDkV6ak2LlfE36YqapCYQV
roecOdpjsJjc0yjn/Fh6n14fVRTma+3DfZlhFK4OitKp/cLxZvzJ7cWpZ2uq
rJEYW1eH8GQXf5xPubq7H189wQUT3bqXj4Gfm5ePIb62qB5D5rZiyxjyBwk/
58PFu4Y2mWnLDGw+tc0d93byO11UpSqPHT/e3u7isNyKazls6G88+8h2Tf5i
Wt1+XzW3Om1lnVcct7KedOt76BrPEGzmNLhSU3t1nLdaYNGBe6kD93VZg0Mn
PTbgOFwuGIZpmUZqHQhVRl3MPCSpPb64hD5cxEaFnlAbEeKFQab9YXJ/x2+m
pOyBFHCkpsALxZ1i7uxeek/7lqWyyyrx/J6zZYjAFR/gpylQ/BqMESCiZTXj
azC63UluwigXSrnIgm3EoNYpdLW0p518T8s6SlyBTU0NH8jawgilxrCTH/AX
w3wxrbCRN+RqNvSJXO1ioqau7uIZebE5/xgQn0v9Y0DXt0FV8LZ2NyyYYjmG
qDwg40GcItY3Q/doY1oWDsNcOAYl68B3S8gusQgbr6FkByvIDXwXW4jMsKuq
mtXECtI6zeY/rVeCibWyoqoF5ua8n8mOGqoUE4fqa5hIBDaExOnFA3ThUoBE
9bDbLgdCwtwMB6E/r8Mg7fUuKAgVXwVBJn0bBpb1sgCBJZ3k0+B40Q7Gn859
LbPn1+xmFPjMhdnrfLbV8LfUesX0t9TM2Wq/O+pxfNpu/PVF9vRM2g7kpw9R
Bx7Za6i9WIIRYNM2FmvH35sp5y7kbOyj9wjezfDrIU2o3Ud/RRoapXdXYlZO
Ishebsn2OUD2xnW/7aPa2T6i3Oqkn4LcYtJP6U1bfFDLWjEEUu6wJjmIPsvj
AE27k6Qk9+YTy16Q0sw4qUQ3lCPJiZNKRrnlVJem5c2ciG2pxL5DQe6UKXH/
pA2YZci+Dm2znG6tivRFBf8i4ddoDjjLA+cZ36QG5A6Xt8xZrFU5CwhlCd6l
UhaplEWFlEUqJc3w1vIZ3tqrGd70jy+IdmebMP9XHDAJiQnO5HiS+JSQjoAj
HSDqT3KdOE90cZaEmPp4c5hL9GEFkaUfLutiS75eE6jL130TsHtNqDbSBLjT
IcCL06Df2XjueBiR7fXF9Mv979cfjcsv00vd+GwYmSv9OLrzrWhVdRDX8ICu
nfR7ZoaYpgu0sjbCXJ4bCnHXphaSV8xP2IhrPmOv/mKYr7eTjfC6b2sj5UJ7
/ZE2EBPpesc0JqQvx2IeXZIcFy79IEKeH7jmiuJrYHoL/K9/09Dw9uLp6s4g
sD8Zy9kvwoH81d2YYolAmtw9kMXjtLh+kk6XrZwsVjpA1sqLGq2bIK9kxSyX
V3O95DEuF06/FFKieMMRtiLeWOmCHQeKSXoU2TbJed3TQJnduGhdyMWHv7br
apqsHfOzyWLLtFdJsiqGpHhVVPf24ZzRP9ehlGJize2ni+nTfUIWI3cmoxiq
J+rIBueMnFzgxgQhOshMYKtTq/P8kO9nMxSpI6FYB7XzE7ly3iY9sVSd2zIV
y/S8LWUxOwHgpQpRHb3uPKj8ZG8wmdGJqCPcQP8MmHME+1EtYYTWZmQtGUlV
yLQ14f3R+i/2nn443TsAAA==
--0-1273997454-1042823563=:22376--
