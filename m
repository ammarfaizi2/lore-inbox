Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264769AbUD1Msg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbUD1Msg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264773AbUD1Msg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:48:36 -0400
Received: from main.gmane.org ([80.91.224.249]:34750 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264769AbUD1Msd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:48:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: What does tainting actually mean?
Date: Wed, 28 Apr 2004 14:48:30 +0200
Message-ID: <yw1x7jw0mfoh.fsf@kth.se>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere>
 <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
 <408F3EE4.1080603@nortelnetworks.com>
 <opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
 <20040428121009.GA2844@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:YNu6rFSMkuP/TcsICqrujksiI58=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> On Wed, Apr 28, 2004 at 03:18:35PM +1000, Nigel Cunningham wrote:
>> On Wed, 28 Apr 2004 01:19:32 -0400, Chris Friesen <cfriesen@nortelnetworks.com wrote:
>> >
>> >There has already been a case mentioned of a binary module that messed  
>> >up something that was only visible once that module was unloaded and  
>> >another one loaded.  It all depends totally on usage patterns.
>> 
>> I don't know what module you're talking about, but surely there must be  
>> something that could be done kernel-side to protect against such problems.  
>> Reference counting or such like? I guess if it was a hardware issue, but  
>> then again that might be an issue with too many assumptions being made  
>> about prior state? Maybe I am being too naive :>
>
> The problem is with corrupted data structures, pointers, etc.  An
> evil/incompetently written driver can screw up data structures long
> after it has been unloaded.  Historically, there was a time when a
> certain set of propeitary six-letter video company beginning with 'N'
> and ending with 'a' had serious bugs which would corrupt the kernel
> and create random kernel panics far removed from the actual source of
> the problems.
>
> Stack overflows in a badly written device driver can overwrite task
> structures and cause apparent filesystem problems which are blamed on
> the hapless filesystem authors instead of where the blame properly
> lies, namely the device driver author.

Wouldn't the problem be just as difficult to pin to a certain module
even if the source code was open?  I prefer open source modules (I
have Alpha machines), but I just can't see this argument work.

-- 
Måns Rullgård
mru@kth.se

