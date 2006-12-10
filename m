Return-Path: <linux-kernel-owner+w=401wt.eu-S1760609AbWLJKGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760609AbWLJKGv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 05:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760612AbWLJKGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 05:06:51 -0500
Received: from web55602.mail.re4.yahoo.com ([206.190.58.226]:29439 "HELO
	web55602.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760609AbWLJKGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 05:06:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=F5d3lxV9DoE3s9uXZPChYq4Sy1uEzeIsXlo2XZ8O1vsZIyAJOrgepiDtzZ49/5PmglBozWq/er+P7SAATxCIcLcnUHvEWrBLQoDqLSEUjeibWmnGOtr15BB9GO6jPQTiXLuY7qTWWvutihUIEb04+6YtRbdE26co9G712UCVYoI=;
X-YMail-OSG: vpx6yvIVM1nW0ak8cpG9uGmuUGRQ7jiC2cE7MLrwtVZW6A2WHcL89V019yJu4edMtSBDREypRtc6rcwDSHrT73FlsP5.98BJJWHxG0Vlz17tSPwSZYfmC_HAKu_Dc8AX45EjmYaolU.7GhrUEi7yGIEdOQC6UZ3kT90d1sWnXK6blYcmQF_qG_VTEtC_
Date: Sun, 10 Dec 2006 02:06:49 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: [PATCH] [DISCUSS] Optimizing linux applications with the help of the kernel.
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <464448.56474.qm@web55602.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I just had an idea for improving the performance of linux applications with some help from the
kernel. Let's say that I have to make a copy of a file. So, I read the input file into a buffer
and then write the buffer to the output file.

In both these cases the same data is coming from kernel_to_user and then from user_to_kernel. If
this can be short-circuited, that is, from kernel_to_kernel then the performance can be increased
a lot.

The psuedocode would be:

fd_inp = open _output_file
fd_out = open _input_file
instruct_kernel to write next data read from fd_inp to fd_out
read fd_out

The same mechanism can be applied to many other scenarios.
May be whatever I am thinking is wrong or involves lot of complexities but this is just a thought.

Regards,
Amit



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
