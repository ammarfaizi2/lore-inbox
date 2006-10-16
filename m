Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422785AbWJPXIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbWJPXIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWJPXIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:08:12 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:6869 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422785AbWJPXIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:08:10 -0400
Date: Mon, 16 Oct 2006 16:07:29 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Matt Helsley <matthltc@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061016230729.GM2747@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>,
	Matt Helsley <matthltc@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
	CKRM-Tech <ckrm-tech@lists.sourceforge.net>
References: <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011220619.GB7911@ca-server1.us.oracle.com> <1160619516.18766.209.camel@localhost.localdomain> <20061012070826.GO7911@ca-server1.us.oracle.com> <1160782659.18766.549.camel@localhost.localdomain> <20061014000951.GC2747@ca-server1.us.oracle.com> <1161027221.6389.135.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161027221.6389.135.camel@linuxchandra>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:33:41PM -0700, Chandra Seetharaman wrote:
> >From what I see, sysfs also has the PAGESIZE limitation. If that _is_
> the case, then moving to sysfs does not help us any. Correct me if I am
> wrong.
> 
> Won't we have the same arguments that we have now ?

	If you use a 'struct attribute' in sysfs, sure, you have the
same limit.  The difference is that sysfs allows you to install your own
files.  So you could create a seq_file of your own and insert it into
your sysfs directory.

Joel

-- 

"I think it would be a good idea."  
        - Mahatma Ghandi, when asked what he thought of Western
          civilization

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
