Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTEFMPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTEFMPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:15:10 -0400
Received: from paveway.thawte.com ([196.36.130.35]:53943 "EHLO
	paveway.thawte.com") by vger.kernel.org with ESMTP id S262687AbTEFMO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:14:57 -0400
Message-ID: <AC7E8D43F95DD041A175D19F74AAB2944B7AB6@zacapex01.cpt.thawte.com>
From: "Botha, Francois" <francoisb@thawte.com>
To: " (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: Panic on all memory used?
Date: Tue, 6 May 2003 14:24:01 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
MIME-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0055_01C313DB.216C0A00"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0055_01C313DB.216C0A00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I'm sure some of us has come across a out-of-memory Linux box, where all
RAM and Swap has been used and the machine just grinds to a halt, but no
full crash (it ping replies!). Something like:

--
 16:03:36 up 21 days, 49 min,  2 users,  load average: 304.70, 264.89,
157.60
 392 processes: 82 sleeping, 307 running, 3 zombie, 0 stopped
 CPU states:   0.0% user,  99.9% system,   0.0% nice,   0.1% idle
 Mem:   3624196K total,  3618928K used,     5268K free,     4792K
buffers
 Swap:  2000084K total,  2000084K used,        0K free,    17312K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   21579 www-data  20   0  4116 3932  2000 R     3.6  0.1   0:06 apache
   21576 www-data  20   0  3576 3392  1980 R     3.5  0.0   0:06 apache
--

At this point a machine tries to kill off processes (based on what
criteria?) but most of the time such a machine rarely "recovers" and
becomes usable again. Would it be very wrong to suggest that maybe a
kernel panic at this point might be a good idea? The saviour could then
be /proc/sys/kernel/panic :P (above example is a paste from a 2.4.20
system).

Don't get me wrong though, yes, processes should clean up after
themselves, this kind of thing "should" never happen, but what to do
when it does under whichever circumstances and the server in question is
co-located and involves lengthy phonecalls?
Does anybody have any suggestions kernel-wise in sitsuations like this
in production environments?

Regards,
Francois Botha

Snr. Systems Engineer
e-mail: francoisb@thawte.com
http://www.thawte.com 

------=_NextPart_000_0055_01C313DB.216C0A00
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII8zCCAoIw
ggHroAMCAQICAwmUNTANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAzMDMyNTA4NDQzMVoXDTA0MDMyNDA4NDQzMVowRjEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEjMCEGCSqGSIb3DQEJARYUZnJhbmNvaXNiQHRoYXd0ZS5jb20wgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAKzJQIL0UFFMv5L/jIPUUNKuN6mWFsDm8eu9FEeDYlos
z+lsjYTA9RqcqbsyDMaGVwlUMTknCdDN3MUjf0x/+K6fjB9fZIdTb/xC/6dT3oA8t5F3wTcXQbZH
ju7l/WZnGOgi+7NHo+tE7G9ATjYlkudvE0gpI+B8DW2N0CJbB6hrAgMBAAGjMTAvMB8GA1UdEQQY
MBaBFGZyYW5jb2lzYkB0aGF3dGUuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEA
1jS9fKJ5X98A4fDMzj1PTH6F80xvmp+1fLkBLeqcqACTW1k8jYq/103nxDK9zsX8ny5QjeahggMZ
98WnKwXS9vfvwnBUf+sZVTTT4gdz83h1RrG1wmr54ySAkEAUs1G8CCWouFDbcXos4nZ8V2UgE7qn
xFPxT119CW+VVUVM3mAwggMtMIIClqADAgECAgEAMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQG
EwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoT
EVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlz
aW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNOTYwMTAxMDAwMDAwWhcNMjAxMjMxMjM1
OTU5WjCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlv
biBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENB
MSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDUadfUsJRkW3HpR9gMUbbqcpGwhF59LQ2PexLfhSV1KHQ6QixjJ5+V
e0vvfhmHHYbqo925zpZkGsIUbkSsfOaP6E0PcR9AOKYAo4d49vmUhl6t6sBeduvZFKNdbnp8DKVL
VX8GGSl/npom1Wq7OCQIapjHsdqjmJH9edvlWsQcuQIDAQABoxMwETAPBgNVHRMBAf8EBTADAQH/
MA0GCSqGSIb3DQEBBAUAA4GBAMfskn5O+PWWpWdiKqTwTRFg0G+NYFhhrCa7UjVcCM8w+6hKloof
YkIjjBcP9LpknBesRynfnZhe0mxgcVyirNx54+duAEcftQ0o6AKd5Jr9E/Sm2Xyx+NxfIyYJkYBz
0BQb3kOpgyXy5pwvFcr+pquKB3WLDN1RhGvk+NHOd6KBMIIDODCCAqGgAwIBAgIQZkVyt8x09c9j
dkWE0C6RATANBgkqhkiG9w0BAQQFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4g
Q2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYG
A1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3
dGUuY29tMB4XDTAwMDgzMDAwMDAwMFoXDTA0MDgyNzIzNTk1OVowgZIxCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3Rl
MR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1h
aWwgUlNBIDIwMDAuOC4zMDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA3jMypmPHCSVFPtJu
eCdngcXaiBmClw7jRCmKYzUqbXA8+tyu9+50bzC8M5B/+TRxoKNtmPHDT6Jl2w36S/HW3WGl+YXN
VZo1Gp2Sdagnrthy+boC9tewkd4c6avgGAOofENCUFGHgzzwObSbVIoTh/+zm51JZgAtCYnslGvp
oWkCAwEAAaNOMEwwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDEtMjk3MBIG
A1UdEwEB/wQIMAYBAf8CAQAwCwYDVR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4GBADGxS0dd+QFx
5fVTbF151j2YwCYTYoEipxL4IpXoG0m3J3sEObr85vIk65H6vewNKjj3UFWobPcNrUwbvAP0teui
R59sogxYjTFCCRFssBpp0SsSskBdavl50OouJd2K5PzbDR+dAvNa28o89kTqJmmHf0iezqWf54TY
yWJirQXGMYIDaTCCA2UCAQEwgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENh
cGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZp
Y2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
CZQ1MAkGBSsOAwIaBQCgggIkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTAzMDUwNjEyMjM1N1owIwYJKoZIhvcNAQkEMRYEFIQ4UwOm6z1ONlae1xSS62JWMJ4+MGcG
CSqGSIb3DQEJDzFaMFgwCgYIKoZIhvcNAwcwBwYFKw4DAhowDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMAoGCCqGSIb3DQIFMIGrBgkrBgEEAYI3
EAQxgZ0wgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNl
czEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAIDCZQ1MIGtBgsqhkiG
9w0BCRACCzGBnaCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAG
A1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNl
cnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMJlDUwDQYJ
KoZIhvcNAQEBBQAEgYB3BrRHG5j+JlZx50Y7xYfPhcgyBvDiV/kQvuzXDcPZe7tKJiPjzxGxmyMn
hOPMnFeLdRTdjuQDOflLc93fRVj3pW+ZllffO/KT/ZFl0bQItWuxZkDLE4+hXw0aFCsGPp071whH
TdtcB1upn7cVxKG5bJ2aqs6xjeiRCxbfZaPuFAAAAAAAAA==

------=_NextPart_000_0055_01C313DB.216C0A00--

