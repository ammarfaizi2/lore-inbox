Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUGMUpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUGMUpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUGMUpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:45:15 -0400
Received: from ms-smtp-04-lbl.southeast.rr.com ([24.25.9.103]:10913 "EHLO
	ms-smtp-04-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S265840AbUGMUpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:45:03 -0400
Message-ID: <40F449BD.2030508@mbio.ncsu.edu>
Date: Tue, 13 Jul 2004 16:44:45 -0400
From: Will Beers <whbeers@mbio.ncsu.edu>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Olaf Hering <olh@suse.de>, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Stuart_Hayes@Dell.com
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
References: <FD3BA83843210C4BA9E414B0C56A5E5C07DD91@ausx2kmpc104.aus.amer.dell.com> <40CF0049.2010307@pacbell.net> <20040713180727.GA11583@suse.de> <40F4457F.2010005@pacbell.net>
In-Reply-To: <40F4457F.2010005@pacbell.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030202070204090100060309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms030202070204090100060309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > though maybe 500 msec is too short a period to wait.
 > See if 5000 msec helps.

I went all the way up to 20000 msec and it still didn't help.  I'm sure 
it's a bad idea, but removing that whole if-block below it makes it work 
(which is effectively what switching the and/or did).  I don't know enough 
about it to judge whether it's correct, but what exactly is it checking for 
there?

-Will

--------------ms030202070204090100060309
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII+TCC
AtcwggJAoAMCAQICAwylZTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwNzA4MDY1OTI1WhcNMDUwNzA4MDY1OTI1
WjBHMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSQwIgYJKoZIhvcNAQkBFhV3
aGJlZXJzQG1iaW8ubmNzdS5lZHUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCw
5/G6HmtFPp9fK1kCwjNTyx4sN3E/AO9uPXDV48IxqXFi7CANR/BvQMaawTEMEa5XjHoGab6O
HyvMGvr6csebsBAryt6LmCvTi3py0pNF5KLBaV98AfgFu4AyoJK+hxIM41XyF2BhS6Cfc/iD
uZuWeWybiUQZLhYVdbU5j928u5ad1jeUqMRNeU7GIC7TOy8lulpugpA9CRocxtNoyibNE7J/
pbSzZXEMVBrNqdwGlKPd7HEhvK941D5IZEId0xul1p0DjlXkugG8q59kapfDosWHfL987Kni
FmUwLbOBPOQagsvDeqd3RQQ6UMYq4Qewz1aAjghhQs/xKpkQfr0NAgMBAAGjMjAwMCAGA1Ud
EQQZMBeBFXdoYmVlcnNAbWJpby5uY3N1LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEB
BAUAA4GBAEN+A34ZDoOVt4uP6MuH1SLoGsMyjrpdLS5McYTz4GAFafHL1YHSKu5vlofkadBs
Hdln1Fe9QyMxA+Ycrp42pt3ZzzxqpF/Vfnp7yieXFjcg6Yg4m5pIfwmmKyU13BVbGfWDGasd
aJ1GpWWvsSDEYLjlWymVz3clCcfAi+yVJl6CMIIC1zCCAkCgAwIBAgIDDKVlMA0GCSqGSIb3
DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5
KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAe
Fw0wNDA3MDgwNjU5MjVaFw0wNTA3MDgwNjU5MjVaMEcxHzAdBgNVBAMTFlRoYXd0ZSBGcmVl
bWFpbCBNZW1iZXIxJDAiBgkqhkiG9w0BCQEWFXdoYmVlcnNAbWJpby5uY3N1LmVkdTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALDn8boea0U+n18rWQLCM1PLHiw3cT8A7249
cNXjwjGpcWLsIA1H8G9AxprBMQwRrleMegZpvo4fK8wa+vpyx5uwECvK3ouYK9OLenLSk0Xk
osFpX3wB+AW7gDKgkr6HEgzjVfIXYGFLoJ9z+IO5m5Z5bJuJRBkuFhV1tTmP3by7lp3WN5So
xE15TsYgLtM7LyW6Wm6CkD0JGhzG02jKJs0Tsn+ltLNlcQxUGs2p3AaUo93scSG8r3jUPkhk
Qh3TG6XWnQOOVeS6Abyrn2Rql8OixYd8v3zsqeIWZTAts4E85BqCy8N6p3dFBDpQxirhB7DP
VoCOCGFCz/EqmRB+vQ0CAwEAAaMyMDAwIAYDVR0RBBkwF4EVd2hiZWVyc0BtYmlvLm5jc3Uu
ZWR1MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAQ34DfhkOg5W3i4/oy4fVIuga
wzKOul0tLkxxhPPgYAVp8cvVgdIq7m+Wh+Rp0Gwd2WfUV71DIzED5hyunjam3dnPPGqkX9V+
envKJ5cWNyDpiDibmkh/CaYrJTXcFVsZ9YMZqx1onUalZa+xIMRguOVbKZXPdyUJx8CL7JUm
XoIwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTAJBgUrDgMCGgUAoIIBpzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA3MTMyMDQ0NDVa
MCMGCSqGSIb3DQEJBDEWBBQysU/4YXKikmuUCxb5zpj+41YIozBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDKVlMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwylZTANBgkqhkiG9w0B
AQEFAASCAQBN0qN3ujjKsmm8+lPnw2BNQ/8VQPJkr2BYuhvlftPF38kWoaah5BxdEHsFnnVS
LzxDNVX9JQhrtQIrNG9fFaT0skC7bqKf9uwFOOeQUjuVBFG0ja89QT31Bd0ztrywG1J8lJ5N
jFaEYeuQ+tOBcgoBL0ehaVHX9ot1ynVu8o/UUiNJuPCo0fT2s1P/1dywaWz7jSpb1yHelgxO
fw2Y433PPGfoBuXN656GxlFnAC8eXqYlQCoGXSHn8TUmprJ6uKMz3r2kVc+hbI7DQ4NyLB7H
etu5sAl4EmrArGXvUD2x//IUpWxlqEAfflSeGC4qogTyhEqI86xQjGDurMHwdPvHAAAAAAAA

--------------ms030202070204090100060309--
