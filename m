Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262989AbTCSLR7>; Wed, 19 Mar 2003 06:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262990AbTCSLR7>; Wed, 19 Mar 2003 06:17:59 -0500
Received: from guard.arkoon.net ([62.161.237.193]:33542 "EHLO
	akguard.arkoon.net") by vger.kernel.org with ESMTP
	id <S262989AbTCSLR6>; Wed, 19 Mar 2003 06:17:58 -0500
X-Lotus-FromDomain: ARKOON
From: mlafon@arkoon.net
To: linux-kernel@vger.kernel.org
Message-ID: <C1256CEE.003EFE8F.00@arkoon-mail.arkoon.net>
Date: Wed, 19 Mar 2003 12:28:02 +0100
Subject: Re: Ptrace hole / Linux 2.2.25
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=WCaTrBW9RMkxaUbdPb7bPj5hTORlUru6Y18LqQhW99Z6wlW98nsRCYTy"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=WCaTrBW9RMkxaUbdPb7bPj5hTORlUru6Y18LqQhW99Z6wlW98nsRCYTy
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Alan Cox wrote:
> Vulnerability: CAN-2003-0127

> The Linux 2.2 and Linux 2.4 kernels have a flaw in ptrace. This hole allows
> local users to obtain full privileges. Remote exploitation of this hole is
> not possible. Linux 2.5 is not believed to be vulnerable.

The patch breaks /proc/<pid>/cmdline and /proc/<pid>/environ for 'non dumpable'
processes, even for root.

We need to access theses proc files for processes monitoring.

Included is a patch to restore this functionnality for root.

Any comments ?
(See attached file: cmdline_environ_fix.diff)
--
Mathieu Lafon - Arkoon Network Security

--0__=WCaTrBW9RMkxaUbdPb7bPj5hTORlUru6Y18LqQhW99Z6wlW98nsRCYTy
Content-type: application/octet-stream; 
	name="cmdline_environ_fix.diff"
Content-Disposition: attachment; filename="cmdline_environ_fix.diff"
Content-transfer-encoding: base64

ZGlmZiAtdSAtcjEuMy4yNC4xIHB0cmFjZS5jCi0tLSBsaW51eC0yLjQva2VybmVsL3B0cmFjZS5j
CTIwMDMvMDMvMTkgMTA6NTA6NTcJMS4zLjI0LjEKKysrIGxpbnV4LTIuNC9rZXJuZWwvcHRyYWNl
LmMJMjAwMy8wMy8xOSAxMDo1NDo0NQpAQCAtMTQwLDcgKzE0MCw3IEBACiAJLyogV29ycnkgYWJv
dXQgcmFjZXMgd2l0aCBleGl0KCkgKi8KIAl0YXNrX2xvY2sodHNrKTsKIAltbSA9IHRzay0+bW07
Ci0JaWYgKCFpc19kdW1wYWJsZSh0c2spIHx8ICgmaW5pdF9tbSA9PSBtbSkpCisJaWYgKCghaXNf
ZHVtcGFibGUodHNrKSB8fCAoJmluaXRfbW0gPT0gbW0pKSAmJiAoY3VycmVudC0+dWlkICE9IDAp
KQogCQltbSA9IE5VTEw7CiAJaWYgKG1tKQogCQlhdG9taWNfaW5jKCZtbS0+bW1fdXNlcnMpOwo=

--0__=WCaTrBW9RMkxaUbdPb7bPj5hTORlUru6Y18LqQhW99Z6wlW98nsRCYTy--

