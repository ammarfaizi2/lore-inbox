Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUBPIsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUBPIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:48:12 -0500
Received: from main.gmane.org ([80.91.224.249]:941 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265463AbUBPIsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:48:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.2: "-" or "_", thats the question
Date: Mon, 16 Feb 2004 09:48:04 +0100
Message-ID: <yw1xy8r3e7gb.fsf@ford.guide>
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it>
 <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu>
 <40306F65.8060702@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-95a870d5.037-69-73746f23.cust.bredbandsbolaget.se
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:s9nsJlu8bkTE969QrycJa7yBtOQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel <harald.dunkel@t-online.de> writes:

> Ryan Reich wrote:
>> Harald Dunkel wrote:
>>
>>>
>>> I am interested in the module file names. 'cat /proc/modules'
>>> should return the correct module names, but for some modules
>>> (like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.
>> According to the modprobe man page, the two symbols are
>> interchangeable.
>>
> I know. But this requires some very ugly workarounds outside
> of module-init-tools. For example, if you want to check
> whether a module $module_name has already been loaded, you
> cannot use
>
>      grep -q "^${module_name} " /proc/modules
>
> Instead you have to use a workaround like
>
>      x="`echo $module_name | sed -e 's/-/_/g'`"
>      cat /proc/modules | sed -e 's/-/_/g' | grep -q "^${x} "
>
> This is inefficient and error-prone.
>
> Maybe somebody has another idea for the workaround,
> but I like the first version.

/proc/modules uses only _ so you could use ${module_name/-/_}.

-- 
Måns Rullgård
mru@kth.se

