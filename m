Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbSAGSJ6>; Mon, 7 Jan 2002 13:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbSAGSJn>; Mon, 7 Jan 2002 13:09:43 -0500
Received: from iweb.mdtsoft.com ([209.101.192.8]:7845 "EHLO iweb.mdtsoft.com")
	by vger.kernel.org with ESMTP id <S284694AbSAGSIe>;
	Mon, 7 Jan 2002 13:08:34 -0500
Message-Id: <200201071807.g07I7AL08968@mdtsoft.com>
Date: Mon, 7 Jan 2002 13:07:10 -0500 (EST)
From: pwd@mdtsoft.com
Reply-To: pwd@mdtsoft.com
Subject: Re: [PATCH] Update to the make rpm system kernel 2.4.17 and 2.5.1 
To: kaos@ocs.com.au
cc: linux-kernel@vger.kernel.org
In-Reply-To: <7074.1010210531@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Jan, Keith Owens wrote:
> On Fri, 4 Jan 2002 15:05:37 -0500 (EST), 
> pwd@mdtsoft.com wrote:
>>I needed to be able to build a bit more complex set of rpm files than
>>the make rpm function allowed. Attached is a patch that will replace
> 
> In kernel build 2.5 the make rpm target does not exist.  kbuild 2.5
> builds the kernel and modules, installs the kernel, modules, System.map
> and .config, that is _all_ it does.  Extra tasks like updating
> bootloader files or building a package using the packaging method of
> the month are _not_ part of kbuild 2.5.  Every user wants to do
> something different with bootloaders and packaging, there is no "one
> size fits all" script.
> 
> 

The reason for the improved rpm build process is not per say for distrubutation
builders; it is for users who have a number of systems to manage and don't want
to have non package things floating around. 

That said it looks like the best thing for me to do might be to move the "make rpm"
function out of the Makefile and into a seperate script when kbuild 2.5 is 
made live in the main line. The rpm build does not use the make system to
build first phase and after that is under the control of RPM itself. 
I assume that the xconfig, oldconfig, config and mconfig are present in
kbuild 2.5?

What is the correct method to tell if 2.5 is live?



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


