Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUCJF1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCJF1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:27:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:12256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbUCJF07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:26:59 -0500
Date: Tue, 9 Mar 2004 21:22:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, rick@rlknight.com
Subject: Re: Dummy network device
Message-Id: <20040309212221.766479dc.rddunlap@osdl.org>
In-Reply-To: <20040309162552.0d7f1ca0.rddunlap@osdl.org>
References: <20040309162552.0d7f1ca0.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Rick Knight
| 
| David S. Miller wrote:
| 
| >On Tue, 09 Mar 2004 15:11:48 -0800
| >Rick Knight <rick@rlknight.com> wrote:
| >
| >  
| >
| >>I found the answer. From the archive. Decided to look at dummy.c and 
| >>numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
| >>like a charm.
| >>
| >>Question/Suggestion, couldn't this be made an option at configuration? 
| >>Kind of like number_of_ptys=256.
| >>    
| >>
| >
| >Specify "numdummies=3" on the module load command line.
| >  
| >
| >It's supposed to be changeable at module load time, without
| >rebuilding it.  Try this e.g.:
| >
| >modprobe dummy numdummies=4
| >
| >--
| >~Randy
| >  
| >
| Randy, David,
| 
| Thanks for the replies.
| 
| I did try 'modprobe dummy numdummies=3', however, I didn't quote 
| numdummies=3. Are the quote required? Is there a modprobe.conf option? 
| Probably "options dummy "numdummies=3".

No, the quotes are not required.  This works for me:
modprobe dummy numdummies=3

Using /etc/modprobe.conf also works, as you suggested, but without
the quotation marks:
options dummy numdummies=3

Either way shows this in /proc/net/dev:

dummy0:       0       0    0    0    0     0          0         0        0
 0    0    0    0     0       0          0
dummy1:       0       0    0    0    0     0          0         0        0
 0    0    0    0     0       0          0
dummy2:       0       0    0    0    0     0          0         0        0
 0    0    0    0     0       0          0


HTH.
--
~Randy
