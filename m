Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVDARas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVDARas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVDARaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:30:07 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33193 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262820AbVDAR2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:28:05 -0500
Message-Id: <200504011727.j31HRv2c011300@laptop11.inf.utfsm.cl>
To: Wiktor <victorjan@poczta.onet.pl>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] 'nice' attribute for executable files 
In-Reply-To: Message from Wiktor <victorjan@poczta.onet.pl> 
   of "Fri, 01 Apr 2005 17:40:04 +0200." <424D6B54.2090200@poczta.onet.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 01 Apr 2005 13:27:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor <victorjan@poczta.onet.pl> said:
> Horst von Brand wrote:
> > Even better: Write a C wrapper for each affected program that just renices
> > it as needed.

> I suggest to implement scalable solution, so the final user wont't have 
> to write separate wrapper for *each* program.

Final user doesn't. It is a job for whoever writes the program, or packages
it for a distro. If even required.

>                                               universal wrapper is 
> better solution, but (now i know, that implementing something that can 
> be dangerous if used incorrectly is so evil, that only the devil could 
> have proposed it) it forces use of database (that normally would be kept 
> in filesystem's file metadata) and if some-malicious-person would have 
> accessed it in write mode (as result of wrong file permissions), the 
> system performerance would be in danger. in my solution, there is 
> per-file attribute, accessible only for root, and if hacker has root 
> permissions, existence of nice attribute is meaningless.

Anything like this that can be accessed by plain users (not root) is
inherently dangerous. It is for a reason that only root can increase the
priority of a process. If you allow reniceing and place some kind of limit
on it, even Aunt Tillie will run her programs with priority maxed out, and
we are back were we are today.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
