Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJQNQV>; Thu, 17 Oct 2002 09:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSJQNQV>; Thu, 17 Oct 2002 09:16:21 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:56580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261415AbSJQNQU>; Thu, 17 Oct 2002 09:16:20 -0400
Date: Thu, 17 Oct 2002 14:21:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, becker@scyld.com,
       jmorris@intercode.com.au, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks
Message-ID: <20021017142149.A23181@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
	becker@scyld.com, jmorris@intercode.com.au, kuznet@ms2.inr.ac.ru,
	netdev@oss.sgi.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <20021015194545.GC15864@kroah.com> <20021015.124502.130514745.davem@redhat.com> <20021015201209.GE15864@kroah.com> <20021015.131037.96602290.davem@redhat.com> <20021015202828.GG15864@kroah.com> <20021016000706.GI16966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016000706.GI16966@kroah.com>; from greg@kroah.com on Tue, Oct 15, 2002 at 05:07:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 05:07:06PM -0700, Greg KH wrote:
> On Tue, Oct 15, 2002 at 01:28:28PM -0700, Greg KH wrote:
> > On Tue, Oct 15, 2002 at 01:10:37PM -0700, David S. Miller wrote:
> > > 
> > > I will not even look at the networking LSM bits until
> > > CONFIG_SECURITY=n is available.

BTW, there's another big issues with LSM:  so far all those hook
have no user in a mergeable shape.  For all other additions
there is a strong need to present something mergable but LSM
doesn't.  IMHO we should require a pointer to a module in mergaable
shape (i.e. certainly not selinux) for each new hook addition.

