Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUJGWDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUJGWDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269697AbUJGV7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:59:50 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:16657 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S268357AbUJGV6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:58:36 -0400
Date: Thu, 7 Oct 2004 23:58:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: mmap specification - was: ... select specification
Message-ID: <20041007215834.GA7047@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156727.31753.44.camel@localhost.localdomain> <001f01c4ac8b$35849710$161b14ac@boromir> <1097160628.31614.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097160628.31614.68.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:50:31PM +0100, Alan Cox wrote:

> I'll quote SuSv3 to illustrate the danger of "specifications"
> 
> "The system shall always zero-fill any partial page at the end of an
> object. Further, the system shall never write out any modified portions
> of the last page of an object which are beyond its end. References
> within the address range starting at pa and continuing for len bytes to
> whole pages following the end of an object shall result in delivery of a
> SIGBUS signal."
> 
> Its a mistake, its not apparent if its actually meant something entirely
> different or someone forgot a "not", or what is going on.

What precisely are you thinking of?
You seem to think this is ridiculous.
The way I read this, Linux is compliant, I think.

[I read this as follows: If you mmap a file with MAP_SHARED and modify
the memory at an address so far beyond EOF that it is not in a page
containing stuff from the file, then you get a SIGBUS. -- Linux does this.
Also, that if you modify the memory at an address beyond EOF, then
the file is not modified. -- Again Linux does this.]

Andries
