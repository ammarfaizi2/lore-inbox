Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTEIK7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbTEIK7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:59:39 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:56757 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S262439AbTEIK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:59:38 -0400
Date: Fri, 9 May 2003 07:09:34 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Shachar Shemesh <lkml@shemesh.biz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Steffen Persvold <sp@scali.com>, D.A.Fedorov@inp.nsk.su,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjanv@redhat.com>,
       Terje Eggestad <terje.eggestad@scali.com>
Message-ID: <200305090711_MC3-1-3821-C039@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shachar Shemesh wrote:

> I'm currently trying to work with some other subscribers of this list on 
> a design. Getting 1, 2 and 3 is a complicated enough task, of course. I 
> would like to hear estimates about inclusion chances should we manage to 
> come up with an implmentation that lives up to all the above.

 How many users would want to actually modify the syscall parameters
or change visible system behavior when a syscall happens?

 Maybe something like this would work?

  1.  You can register to be notified when a syscall occurs,
      either before or after or both.
  2.  The only action you can take must be 'private' (within
      your driver or subsystem.)


