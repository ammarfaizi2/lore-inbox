Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVBHD0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVBHD0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 22:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVBHD0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 22:26:46 -0500
Received: from ares.cs.Virginia.EDU ([128.143.137.19]:9108 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id S261453AbVBHD0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 22:26:41 -0500
Message-ID: <03cd01c50d8e$00dd2fe0$3b3f8f80@cs.virginia.edu>
From: "Xiuduan Fang" <xf4c@cs.virginia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Question about sendfile
Date: Mon, 7 Feb 2005 22:26:39 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03CA_01C50D64.17E10240"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_03CA_01C50D64.17E10240
Content-Type: text/plain;
	format=flowed;
	charset="gb2312";
	reply-type=original
Content-Transfer-Encoding: 7bit


Hi,

I am trying to beat the I/O bottleneck so as to speed up bulk data transfers 
in high speed network. It seems that the system call sendfile() can help to 
reduce CPU utilization and speedup data transfers. But I have one question 
about the system call,

First,  Linux sendfile requires that the input file descriptor cannot be a 
network socket. What are the reasons for such a restriction? Sending a 
socket to a file via zero copy is definitely useful.  Actually this is one 
approach I am trying to do to improve performance.  Some discussions on 
Linux zero copy said this is because it is harder. Sending a socket to a 
file via zero copy needs the support of NICs. I cannot understand this 
explanation. It seems that FreeBSD has implemented bidirectional zero 
copy(http://people.freebsd.org/~ken/zero_copy/#Download). So why Linux does 
not support it? What shall I do to release the restriction that Linux 
enforces on sendfile?

Any hints will be highly appreciated. Thanks.

Xiuduan Fang 

------=_NextPart_000_03CA_01C50D64.17E10240
Content-Type: text/x-vcard;
	name="Xiuduan Fang.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Xiuduan Fang.vcf"

BEGIN:VCARD
VERSION:2.1
N:Fang;Xiuduan
FN:Xiuduan Fang
ORG:University of Virginia;Computer Science Dept
TITLE:2nd Year Graduate
TEL;WORK;VOICE:1-434-982-2296
ADR;WORK:;;151 Engineer's Way, P.O. Box =
400740;Charlottesville;VA;22904-4743;USA
LABEL;WORK;ENCODING=3DQUOTED-PRINTABLE:151 Engineer's Way, P.O. Box =
400740=3D0D=3D0ACharlottesville, VA 22904-4743=3D0D=3D
=3D0AUSA
KEY;X509;ENCODING=3DBASE64:
    =
MIIEYzCCA8ygAwIBAgIQJav9Aj366wHb4hpgZ1JRKDANBgkqhkiG9w0BAQQFADCBzDEXMBUG
    =
A1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsx
    =
RjBEBgNVBAsTPXd3dy52ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9SUEEgSW5jb3JwLiBCeSBS
    =
ZWYuLExJQUIuTFREKGMpOTgxSDBGBgNVBAMTP1ZlcmlTaWduIENsYXNzIDEgQ0EgSW5kaXZp
    =
ZHVhbCBTdWJzY3JpYmVyLVBlcnNvbmEgTm90IFZhbGlkYXRlZDAeFw0wNDEwMDQwMDAwMDBa
    =
Fw0wNDEyMDMyMzU5NTlaMIIBBzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNVBAsT
    =
FlZlcmlTaWduIFRydXN0IE5ldHdvcmsxRjBEBgNVBAsTPXd3dy52ZXJpc2lnbi5jb20vcmVw
    =
b3NpdG9yeS9SUEEgSW5jb3JwLiBieSBSZWYuLExJQUIuTFREKGMpOTgxHjAcBgNVBAsTFVBl
    =
cnNvbmEgTm90IFZhbGlkYXRlZDEnMCUGA1UECxMeRGlnaXRhbCBJRCBDbGFzcyAxIC0gTWlj
    =
cm9zb2Z0MRUwEwYDVQQDFAxYaXVkdWFuIEZhbmcxIzAhBgkqhkiG9w0BCQEWFHhmNGNAY3Mu
    =
dmlyZ2luaWEuZWR1MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDRn6bRIKJguTHWwMQB
    =
aKdf9VOH3758Ba6owaoGy5ME/fds2ZPTWvuW+IyFskupZ0stK7f9OtzKAi+EFkFlD1umHItr
    =
XM74PapnYI/8TR/svKbZJLodGNAto9sJjvLQkNK6hwvTp5eBwQ1YgC7GmZHmtshPH8N+8Ast
    =
xOxoflE6dwIDAQABo4IBBjCCAQIwCQYDVR0TBAIwADCBrAYDVR0gBIGkMIGhMIGeBgtghkgB
    =
hvhFAQcBATCBjjAoBggrBgEFBQcCARYcaHR0cHM6Ly93d3cudmVyaXNpZ24uY29tL0NQUzBi
    =
BggrBgEFBQcCAjBWMBUWDlZlcmlTaWduLCBJbmMuMAMCAQEaPVZlcmlTaWduJ3MgQ1BTIGlu
    =
Y29ycC4gYnkgcmVmZXJlbmNlIGxpYWIuIGx0ZC4gKGMpOTcgVmVyaVNpZ24wEQYJYIZIAYb4
    =
QgEBBAQDAgeAMDMGA1UdHwQsMCowKKAmoCSGImh0dHA6Ly9jcmwudmVyaXNpZ24uY29tL2Ns
    =
YXNzMS5jcmwwDQYJKoZIhvcNAQEEBQADgYEASTrowJeKxyNUZbF+AwGXfqXBrOyN3b+3aRDN
    =
CgSQVp0zaLHwLReTa+3mEnwtrMN6QSM02gPbiuzVkdmGyxmlHAmrHQ2l61fyotoMH47RJbe+
    qzClrcMr2Y9AAyTNeVrvfSZRdKMZ9HFduUu1tn5/FTZFCK8Xoaq3BIo81b8nHGs=3D


EMAIL;PREF;INTERNET:xf4c@cs.virginia.edu
REV:20050208T032639Z
END:VCARD

------=_NextPart_000_03CA_01C50D64.17E10240--


