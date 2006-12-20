Return-Path: <linux-kernel-owner+w=401wt.eu-S965107AbWLTOj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWLTOj1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWLTOj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:39:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:38693 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965110AbWLTOj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:39:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender;
        b=t51tsSiLTApONbixDzNJZJTR5PzfQ1EmihlCPzmySTVKRic3BsMjmUfqc9jSsKVCUaCzGuY29riVnvtXF86vFMuz1bJtZ3HJv6whYDIIeb4e+8dPL+BgDdZaZslmEV5XdHGsdeGqUmL+6jVRZfnhFnXh6M7XBKE5kva2vJdddD4=
From: David Wragg <david@wragg.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       bcrl@kvack.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	<878xh2aelz.fsf@wragg.org>
	<1166622487.3365.1386.camel@laptopd505.fenrus.org>
Date: Wed, 20 Dec 2006 14:38:06 +0000
In-Reply-To: <1166622487.3365.1386.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed\, 20 Dec 2006 14\:48\:06 +0100")
Message-ID: <871wmuab01.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> if all you care is the number of context switches, you can use the
> following system tap script as well:
>
> http://www.fenrus.org/cstop.stp

Thanks, something similar to that might well have solved my original
problem.  

(When I try the script, stap complains about the lack of the kernel
debuginfo package, which of course doesn't exist for my self-built
kernel.  After hunting around on the web for 10 minutes, I'm still no
closer to resolving this.  But I look forward to playing with
systemtap once I get past that problem.)

Nonetheless, while systemtap might provide an objection to adding
per-task context switch counters to the kernel, it doesn't answer the
question, since we do have these counters, why not expose them in the
normal way?


David
