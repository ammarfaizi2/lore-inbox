Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTLEX0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTLEX0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:26:03 -0500
Received: from main.gmane.org ([80.91.224.249]:38598 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264594AbTLEX0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:26:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Sat, 06 Dec 2003 00:25:56 +0100
Message-ID: <yw1xad663kzf.fsf@kth.se>
References: <200312041432.23907.rob@landley.net> <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
 <yw1xllprihwo.fsf@kth.se>
 <20031205224142.GR29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:hIYHlUhCDT7xoe10YisU5lxJhB4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

>> I found this paragraph in the man page of GNU cp:
>> 
>>        --sparse=WHEN
>>               always Always make the output file sparse.  This is
>>                      useful when the  input  file  resides  on  a
>>                      filesystem  that  does  not  support  sparse
>>                      files, but the output file is on a  filesys-
>>                      tem that does.
>
> So with this, you can create sparse files for an entire set of files
> by just cping them? :)

Yes.  It won't query the system for where any potential holes in the
source files might be, though, so if there are large holes, cp will
spend unnecessary time crunching through them.

-- 
Måns Rullgård
mru@kth.se

