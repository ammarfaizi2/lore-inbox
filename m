Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTATAeU>; Sun, 19 Jan 2003 19:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTATAeU>; Sun, 19 Jan 2003 19:34:20 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:8714 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267741AbTATAeT>; Sun, 19 Jan 2003 19:34:19 -0500
Date: Mon, 20 Jan 2003 00:43:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Russell Coker <russell@coker.com.au>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
Message-ID: <20030120004320.A10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Russell Coker <russell@coker.com.au>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <200301172154.QAA00757@moss-shockers.ncsc.mil> <20030120000853.A9023@infradead.org> <200301200139.39092.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301200139.39092.russell@coker.com.au>; from russell@coker.com.au on Mon, Jan 20, 2003 at 01:39:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 01:39:39AM +0100, Russell Coker wrote:
> > What's the reason you can't just live with DAC for sysctls?
> 
> What exactly do you mean by "live with DAC" in this context?  If you mean 
> "allow UID==0 processes to do whatever they like" then it's not going to work 
> for any sort of chroot setup.

This means check the unix file permissions / ACLs only overriden by
CAP_FOWNER processes.

