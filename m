Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279929AbRJ3Lqn>; Tue, 30 Oct 2001 06:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRJ3Lqb>; Tue, 30 Oct 2001 06:46:31 -0500
Received: from viap112.atea.be ([194.78.143.112]:4103 "EHLO hrtades9.atea.be")
	by vger.kernel.org with ESMTP id <S279928AbRJ3LqJ>;
	Tue, 30 Oct 2001 06:46:09 -0500
Date: Tue, 30 Oct 2001 12:49:18 +0100
From: david.heremans@siemens.atea.be
To: linux-kernel@vger.kernel.org
Subject: Low-level help needed with leds
Message-ID: <20011030124918.A1932@PCF988>
Reply-To: david.heremans@siemens.atea.be
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello all,

I'm writing to this maillinglist as a last resort, since reading books
and other peoples code didn't solve my problem, and it is on the vague
boundary of userspace/kernel.

I recently got hold of a nice little piece of hardware that must be
connected between the computer and the keyboard. You can program this
device by sending it bytes trough the keyboard-leds.
More about this device at http://www.andywarne.pwp.blueyonder.co.uk/,
the device is called the I-Pac.

The programming protocol description I got from the maker of this hardware states this
sequence.
1. Set any led combination execpt all leds on.
2. Send five times all leds on.
3. The I-Pac will send a key-down code for the 'Y' (ready to program) or
'J' (jumper set to fixed) key.

I don't get this key code back.
I was wondering if I misunderstood the way the Linux kernel sends this
LEDs commands. Does it send extra led commands that I don't know about?
Maybe it doesn't send twice the same led formation since it would be a
logical optimisation? Honestly, I'm completely clueless by now, and
digging into the Linux source code is way to complicated for me, I
honestly tried but got lost in it (tasklets et all) :-(

I took the liberty of attaching a simplified version of
my programming tool. If some of the more knowledgable people here could
please help me out, thanks.

Sincerely,
David Heremans

PS: I'm not subscribed to this list, I just scan the archieves and
digests from time to time. So I you reply please put me in CC.
PPS: When compiling the c program I also got redefine warnings in
headers, sugestions to solve these are also welcomme, the include list I
use is a mix of other example programs, so I'm not sure which are the
exact ones to use.

--wRRV7LY7NUeQGEoC
Content-Type: application/x-gtar
Content-Disposition: attachment; filename="led_test.tgz"
Content-Transfer-Encoding: base64

H4sIAJ6azDsAA+1Ze1MbyRHnX/ZTNLo6W1IErMQrsQ5XYYFzsgW4TiSOK05Ro9VImrCaUe3s
IlQO+ezpnofYFQLkO+qSVDHFc6a7p+c33T3drUhJrWK+GYve5iRRw4SNN8WERVtCRmvPNMJ6
GO7v7q6FYVg/2Avzv2nshwc7a/i93zjY3wkbe0i/t1M/WIPwuRR4bGQ6ZQnAWp9di/4jdE+t
/5+OH/Ce46zP4Sed9oXaGr0N7qZ4ksiFqZQnY6F0cTKTArmLc3qmt4WK0rg4HQuZ3WxfGeIA
oU9FBDpNsiiFdScbNLvml+6fGvSyATSDaIS3tL4eWXMdqz5vBkKmgEJjNoND2ENLasL29h6M
RRwLzZG0ry0fCYx5vxnYf6uTZCjZGCUE21UYZDJKhZKA5p+qdDbhGqrbwbUSfbjis55iSf9S
SJGWaarSXF9fR64R05Aq6HGIWIyy8a+BSjgwOQM1gHTEQeGPZC7eCDUqay77yKHLmdRiKJHX
aEVTNSACc6RKc07cm6V8gZimHEXCdYo7G4k4ZebSdHYZ9RLOrsqkMOo7yXCWIJUspk0UMLAU
QGCScp4xYdOyP+YyNly/z8M1T/1eTqM7Rk9t8BbjCV4gl3T3DpaHsP4tUH8LAK0Buui2cghR
liS4JXROjtG+eJriJBKIAZTBWGm5e3HcPrt83+6cnJ3X4OPxn08ukLgGr5zxVKBCIgEGkwRP
PSijxaN/1KD0o37jZFTmfDBgglR9Az/qr7JUA2dyNTJ2ZFNJ2ThXBW9sqdAvKgPJUQKePMkk
nlJoGCRqbM7r3KCGGMANwQxTNHqQCo1HbeCGTiy/QSgblSbgf7doG3lIjBwHi8feQ6ObT4Dz
8d3p+fEJIDw5j3wYohw8jnMRn+WweP1Jffx2SqXRkKP1pElRr1f5uFGBnyA06qwvaFMqGBqM
WeztxuNGW1HUOSxEIgwuVReqsoSuYDIjO0Otbr/Lr41l0jGWQ9u1dkdcldUsrvsrLI6OmOmY
80nZRRuyDDMB6FwmrM4wkkaJ8pE0d8qHApI5mlO2RIRkZ7SCSglSyoUtuMPKLMMrOIBa5uNe
frlM62/f7lSeptknmp0cjdO4ECDn6M/ZnX97tocwb6ks7hsP8+FNJWJowhvB7h0HTwnOeBOO
hiKh0bTON58IjWb34jSsFqW/Pe6Z3blnfrz8W+fo4oScEp7yyu6v9kr6EXyPv1jaregyHsRs
CK8O4d9lOGn9fA7/gnbr6Oz8rGI4eTRSGN4HNYz6UkkR+XcE56zfWTFR9Pe/nrbP/oG71w2j
ktwaFUsRvVSM+SL5Rfv0hOhDQy+VIUqccjbA6GUBBi5aXVTwM0Y9FGYjDAUYd6/lzXold83l
0JpgUHxYH7rm/Kv6HXf8y9HnVcLub7xggIdiLgFhnpdoMGZXnI5o5yzb/8odLQNnRQmrQLZ4
5QtpETyWFH1zD9sTV51/Z5srY3D/SQwWzfU7XrriMf/bpcvLeIZRqPmfreIvDlP/h+GD9f/+
rq3/d+r13XqjgfSNvd3dl/r/9xjb1QCqULQCDEdV+wUXGLUw+E1FOoLGVmOrfoCx25QON3/c
B5ZEo4BCw7y+L0WP9JNKQfBouwGnkG2F1kKKoXy4MIe5KFvoNURUzD/Z0aBGhan6709Tf6I4
O4jkYkdjlUYHxtOuwkduGKsehv5rlgjWi22jIfihzwcCH8T2p6PW5ZfLUwhv6nsUgktfSrAJ
R9GVVFN8goYcTvGJhRY9HPlBF1CU8Q5l/OkBGe9MOrkoZFFGy+jRODEyWiSjNeLRlc7GcEKv
3zJV7ssgPY4elmFUKUpZlPHB6rFrZHwgGR+y8QQzga5LuJeoc1+G0eNJGb2cOosyztodlBGG
JOMCUxGFKZzlenjkLxcrtMuzcwAScKagg5VHbgta7XYA6rjaxZoLa/mOiq4WKM6QokH8COCS
5RYu0xlbbKKXrR91OlhCbVePSLrdPygWcZji+eLYVUrFdeETDwSqv5AIilrd104uTTDUt8Bj
zWFpglo6Fn35OqVtTTOnz1Jmexxei7tOhk89SI9K6DLTW7Nksi0Xay4p1tjm0RL9TVujOIU7
0e9mrnDlEvMgqlx9X+ANLN/Ba5dG/YQJWQDEFtRTJlJTTzPEHE3GJP6mlZUmTOqxSDG6kgRX
HRQlPJl2UzNnNK9LKVGl23HCYKqSK97fWJaFm06pycC16TIZJe4n33uWzuXeQkI9TEeamm6+
KUAarpJF27MM4kyPinQXrfb5+85fuj/b4xgKg1ZP4ZPTlojY9nlGuNERkdoQ4x+WizpaVfhk
r8a8S+3NTyxydQIu1bfgU8v0CrSxsRhtLSIH5zcRn6RQor3QO7r4rpVMkjtvDFiXy7ccrMhG
TuQe6CyKuNbims9laZJldtFwXyS64dI2xu+yZk+ws0UwHbWcV2nqMqATsAgNfwsuqNWIX0yj
6cZqqt+Qm1Xv4hq9KWOO9gul8481oGAwM1ZugO3FGHpKiywf5iwu9qLVkCucHp2emBKfrte5
mGUm4Jx3HhYCE51wSU/P6GHDh7EB6jkBVWxlpKw4ScuqNXLuMfkv/cGSYVSzoaFaxX+uXccI
l4SNRIjfe5FoNCN6zIzDodk51U2zOlF0Fqql0C4wHwrsa2C71FOB4XDK7xq2GAwoFyAwcFuJ
LzTJIzMK/CtCvyjsIgw8EwgBbBy67ubqzWOvoVcQ72uGdAi9UQP9OcWHZ7455NrIhY7AQky/
i5u/ZFL6xrLfzCSONGGjTB6Vr/Jug9vAQ2tUtX1I/APx4vBPTNERpYhlmtt1/OI3jD5H8Bt5
iDHcCh/S6PT0tND2JqZvohFsZhPg19TzpsNT3kdkVAOkecW9vDxy2pFNR9ymwCSur6aStkz4
EBNVVLdPTfk+3fAoG5PBs4R7aRp3QodCZmZ3GxhDIuMtgGZCujFnlOx3og4m09T/ulPOHQyX
twrG4lq7O7bAsqE1TTifx20Pd4enr+kDEU72NeXGGszG+U8HKJT84e4jAoz23G9U/NDG3aY3
CJoTJt2NM9LbCIK5X/oPVppBgeurNLmcptaDAUoq9/nO/B4QUvRIfCu4jLzFoc2+1hsb3qqM
SCkiXt5shLaj+JlbxvFEJSnDc73ZrLiHwmDh4UcbcqcrPPleqJWE6bQDy7V17C1ZiBz7widz
NJX/rGwuTqpkjDCRj3lW42+k90uf5WW8jJfxMl7Gy3gZzz3+A4KYZVAAKAAA

--wRRV7LY7NUeQGEoC--
