Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWELLJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWELLJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWELLJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:09:22 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:62398 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751206AbWELLJV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:09:21 -0400
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
In-Reply-To: <1147421427.3969.60.camel@frecb000686>
References: <20060510112701.7ea3a749@frecb000686>
	 <20060511091541.05160b2c.akpm@osdl.org>  <20060512063220.GA630@elte.hu>
	 <1147421427.3969.60.camel@frecb000686>
Date: Fri, 12 May 2006 13:13:39 +0200
Message-Id: <1147432419.3969.70.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 13:12:19,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 13:12:23,
	Serialize complete at 12/05/2006 13:12:23
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 10:10 +0200, Sébastien Dugué wrote:
> On Fri, 2006-05-12 at 08:32 +0200, Ingo Molnar wrote:
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Should the futex code be using hlist_heads for that hashtable?
> > 
> > yeah. That would save 1K of .data on 32-bit platforms, 2K on 64-bit 
> > platforms.
> 
>   I'll try to look into this.
> 

  Well, moving the hash bucket list to an hlist may save a few bytes on
.data, but all the insertions are done at the tail on this list which
would not be easily done using hlists.

  Any thoughts?

  Sébastien.

