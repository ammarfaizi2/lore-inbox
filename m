Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRJDK1M>; Thu, 4 Oct 2001 06:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRJDK1C>; Thu, 4 Oct 2001 06:27:02 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:53467 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S273305AbRJDK0y>; Thu, 4 Oct 2001 06:26:54 -0400
From: Christoph Rohland <cr@sap.com>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
In-Reply-To: <E15p4qy-0000yf-00@pmenage-dt.ensim.com>
Organisation: SAP LinuxLab
In-Reply-To: <E15p4qy-0000yf-00@pmenage-dt.ensim.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Message-ID: <m3snczogal.fsf@linux.local>
Date: 04 Oct 2001 12:25:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 04 Oct 2001, Paul Menage wrote:
>>> The only real user-space solution to this is to have the SIGCHLD
>>> handler somehow cause the select() to return immediately
>>
>>... or implement pselect:
>>http://mesh.eecs.umich.edu/cgi-bin/man2html/usr/share/man/man2/select.2.gz
> 
> Agreed, althought that's not a user-space solution. Is there any
> fundamental reason why no-one's implemented pselect()/ppoll() for
> Linux yet?

Missing knowledge and/or demand? It should be pretty easy to
implement.

>>or use sigsetjmp/siglongjmp
> 
> Yes, that would probably solve the situation in question, provided
> that siglongjmp() is portably safe. (A comment on LKML in the past
> suggested that it's not safe on cygwin, for example.)

It should be at least portable between different U*X versions. I never
used cygwin though.

Greetings
		Christoph


