Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288745AbSADUHN>; Fri, 4 Jan 2002 15:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADUHD>; Fri, 4 Jan 2002 15:07:03 -0500
Received: from iweb.mdtsoft.com ([209.101.192.8]:53403 "EHLO iweb.mdtsoft.com")
	by vger.kernel.org with ESMTP id <S288743AbSADUGr>;
	Fri, 4 Jan 2002 15:06:47 -0500
Message-Id: <200201042005.g04K5bZ19255@mdtsoft.com>
Date: Fri, 4 Jan 2002 15:05:37 -0500 (EST)
From: pwd@mdtsoft.com
Reply-To: pwd@mdtsoft.com
Subject: [PATCH] Update to the make rpm system kernel 2.4.17 and 2.5.1
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_iweb.mdtsoft.com-24203-1010174802-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_iweb.mdtsoft.com-24203-1010174802-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from binary to 7bit by courier 0.36

I needed to be able to build a bit more complex set of rpm files than
the make rpm function allowed. Attached is a patch that will replace
the scripts/mkspec file with a perl program that generates a bit better
spec file, the change to the top level Makefile that will use perl not
bash for mkspec and a file for the Doc... directory explaining the changes.

If there is anyone using the make rpm could take a look at this and let
me know if it works with your build. I have tested this under a production
build based on 2.4.17 and a build with default configuration under 2.5.1
(I can't build any of my standard configuration for 2.5.1 due to buslogic
dirver problems) and it does what I intended it to.

the attachment is a gziped patch file made from /usr/src with diff -urN

-- 
It is MDT, Inc's policy to delete mail containing unsolicited file attachments.
Please be sure to contact the MDT staff member BEFORE sending an e-mail with
any file attachments; they will be able to arrange for the files to be received.

This email, and any files transmitted with it, is confidential and intended
solely for the use of the individual or entity to whom they are addressed.
If you have received this email in error, please advise postmaster@mdtsoft.com
<mailto:postmaster@mdtsoft.com>.

Philip W. Dalrymple III <pwd@mdtsoft.com>
MDT Software - The Change Management Company
+1 678 297 1001
Fax +1 678 297 1003



--=_iweb.mdtsoft.com-24203-1010174802-0001-2
Content-Type: application/octet-stream; name="patch-kernel-rpm-0.1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-kernel-rpm-0.1.gz"

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

--=_iweb.mdtsoft.com-24203-1010174802-0001-2--
