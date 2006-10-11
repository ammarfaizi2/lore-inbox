Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWJKJMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWJKJMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWJKJMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:12:38 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:1119 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965205AbWJKJMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:12:37 -0400
Date: Wed, 11 Oct 2006 02:12:14 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Use seq_file for read side of operations
Message-ID: <20061011091214.GU7911@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>, akpm@osdl.org,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010182055.20990.77906.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010182055.20990.77906.sendpatchset@localhost.localdomain>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:20:55AM -0700, Chandra Seetharaman wrote:
> +	error = single_open(file, configfs_read_file, buffer);
> +	if (error) {
> +		kfree(buffer);
> +		goto Enomem;
> +	}

	Btw, with single_open(), how do you ever get more than one call
to ->show()?  Shouldn't single_next() prevent that?

Joel

-- 

Life's Little Instruction Book #451

	"Don't be afraid to say, 'I'm sorry.'"

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
