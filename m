Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSAaTfX>; Thu, 31 Jan 2002 14:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288327AbSAaTfO>; Thu, 31 Jan 2002 14:35:14 -0500
Received: from [208.179.59.195] ([208.179.59.195]:19000 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S284264AbSAaTfG>; Thu, 31 Jan 2002 14:35:06 -0500
Message-ID: <3C599C66.30202@blue-labs.org>
Date: Thu, 31 Jan 2002 14:35:02 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020128
X-Accept-Language: en-us
MIME-Version: 1.0
To: Deepinder Singh <dsingh@somanetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory leaks with GRE Tunnels
In-Reply-To: <3C598DE3.8090405@somanetworks.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020400080200050608070306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020400080200050608070306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I use GRE tunnels a lot.  I have run my rc.networking script several 
dozen times with no problems and everything is cranking along nicely. 
 You can view my scripts at http://blue-labs.org/.  I always use a 
single numbered interface, "gre1".

However the below really is a bug that should be fixed I would imagine.

David

Deepinder Singh wrote:

> Hi ,
>
> I have been doing some testing using GRE tunnels in Linux ( which btw 
> work great ). I found that creating and deleting a tunnel results in a 
> memory leak.
>
> To test it out I wrote a small script that basically loops around 
> creating and then deleting 8000 tunnel interfaces at a time. On the 
> eighth iteration  the system hangs a whole with no error messages. 
> There  was still enoungh virtual memory around even with the leaks so 
> I figured something else is wrong. It turns out that the interface 
> numbers ( as seen in ' ip link ls' )  do not seem to be reused when an 
> interface is deleted and as such the system hangs when the number 
> reaches 64K.
>
> I suspect the two issues are realted but am more of a cisco guy and 
> know kernel internals. The total mem leak for the 64 K tunnels is 
> about 200 megs.
>
> Please cc me if you reply to this post as I am not on the list.
>
> thanks,
> Deepinder Singh
> Sr. Network Eng.
> Soma Networks
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--------------ms020400080200050608070306
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJYDCC
Aw4wggJ3oAMCAQICAwZepDANBgkqhkiG9w0BAQIFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAxMTIyMjA4MzkyMFoXDTAyMTIyMjA4MzkyMFowSjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEnMCUGCSqGSIb3DQEJARYYZGF2aWQr
Y2VydEBibHVlLWxhYnMub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsoCV
YNGPjureulr7FgVUurk6LiiozxKNqk7YgdbsUZoZ80KCKIjveE7ukwKi6A980uA9lJxXWqcU
RVu/SHCt/G/DXXu4WXrcQR8mflKbISnGAVPKKN4LiZZEbFZ/RxZgUQ/2OzOGt00oHuQ1TvWX
NPxKYxwUhVLh4tw9XlNDK7qQHdanp5mzuZdpuMgq1pilDdhYa5i/L87f7aF0SoDKlCBvnhSw
LNe2BV6NBXNhhgJE6dz6qD9B8cgsSZWccHFjFF4lO23hMl/DlFK0GMa7DcWfz891+0dI39w2
KO7wg8FUVnzrZHoDAsPZ2vI2O3eowLiGQR5LWq9Ppa02jPjbKwIDAQABozUwMzAjBgNVHREE
HDAagRhkYXZpZCtjZXJ0QGJsdWUtbGFicy5vcmcwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0B
AQIFAAOBgQAEDATO3Nq34ZbuCVE7RQneB2/h5KUSQ1raF8FqnJq9Mr5c12VzlkInI8odiCUB
etciZCnE1u84bewgh4pu6AhAqfRU3u178fP8zDNILQaHsHjqxbZzmvT9dLyaU2GiaCN+KLZw
Ws/+HOFJWwNIbRt5nbJ+mGwTHZ2xzc5jVFKG3zCCAw4wggJ3oAMCAQICAwZepDANBgkqhkiG
9w0BAQIFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UE
BxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNl
cnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMB4XDTAx
MTIyMjA4MzkyMFoXDTAyMTIyMjA4MzkyMFowSjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWls
IE1lbWJlcjEnMCUGCSqGSIb3DQEJARYYZGF2aWQrY2VydEBibHVlLWxhYnMub3JnMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsoCVYNGPjureulr7FgVUurk6LiiozxKNqk7Y
gdbsUZoZ80KCKIjveE7ukwKi6A980uA9lJxXWqcURVu/SHCt/G/DXXu4WXrcQR8mflKbISnG
AVPKKN4LiZZEbFZ/RxZgUQ/2OzOGt00oHuQ1TvWXNPxKYxwUhVLh4tw9XlNDK7qQHdanp5mz
uZdpuMgq1pilDdhYa5i/L87f7aF0SoDKlCBvnhSwLNe2BV6NBXNhhgJE6dz6qD9B8cgsSZWc
cHFjFF4lO23hMl/DlFK0GMa7DcWfz891+0dI39w2KO7wg8FUVnzrZHoDAsPZ2vI2O3eowLiG
QR5LWq9Ppa02jPjbKwIDAQABozUwMzAjBgNVHREEHDAagRhkYXZpZCtjZXJ0QGJsdWUtbGFi
cy5vcmcwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQIFAAOBgQAEDATO3Nq34ZbuCVE7RQne
B2/h5KUSQ1raF8FqnJq9Mr5c12VzlkInI8odiCUBetciZCnE1u84bewgh4pu6AhAqfRU3u17
8fP8zDNILQaHsHjqxbZzmvT9dLyaU2GiaCN+KLZwWs/+HOFJWwNIbRt5nbJ+mGwTHZ2xzc5j
VFKG3zCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdEx
CzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93
bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBD
QTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4
MzAwMDAwMDBaFw0wNDA4MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2Vz
dGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UE
CxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJT
QSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7Sbngn
Z4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmF
zVWaNRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ
7JRr6aFpAgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwx
LTI5NzASBgNVHRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOB
gQAxsUtHXfkBceX1U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BV
qGz3Da1MG7wD9LXrokefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvK
PPZE6iZph39Ins6ln+eE2MliYq0FxjGCAycwggMjAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEV
MBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRo
YXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFs
IEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwZepDAJBgUrDgMCGgUAoIIBYTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMjAxMzExOTM1MDJaMCMGCSqGSIb3
DQEJBDEWBBTCViXEo4+htEZzZrSsUwiU5xhiEDBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDCBrQYLKoZIhvcNAQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxX
ZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYD
VQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwg
UlNBIDIwMDAuOC4zMAIDBl6kMA0GCSqGSIb3DQEBAQUABIIBAI2uo/apdJtMBHW1eMUoVR03
1kadqyx64gXLITxWPN0dEgoi4Ge1ix6eTOO0XLjK7D/vU7iHlwXwji/xhSgIQyvX7YFfmQwP
zE3G7OT+xqG90iVJlM2BNxPkI8a5WY/Ktr93ZVFGUVOi9Ikih/A8c9o43919KLyl1BmHeu9g
qGdhrMa3DF2yxSVqOlHLrjXmeFVVhB0Nkt2qfj7pJZg17ofWqeJB1qgWxzdwVGtM7b1NLcDC
JyOYHSV6oXfxhXG9MRKdaqbC9wv1usgOu7tOi11YUVPwRnJiJxta2BIF5j2yhF2sRdgNKIVR
M53MPvY/mgQBLY5xdeCB+bbz9PkPTOsAAAAAAAA=
--------------ms020400080200050608070306--

