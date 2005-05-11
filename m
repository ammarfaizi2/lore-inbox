Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVEKIwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVEKIwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEKIwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:52:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51626 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261932AbVEKIvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:51:55 -0400
Date: Wed, 11 May 2005 09:51:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511085154.GB24495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	smfrench@austin.rr.com
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <a4e6962a05050406086e3ab83b@mail.gmail.com> <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 04:21:23PM +0200, Miklos Szeredi wrote:
> Yes, I see your point.  However the problem of malicious filesystem
> "traps" applies to private namespaces as well (because of suid
> programs).
> 
> So if a user creates a private namespace, it should have the choice of:
> 
>    1) Giving up all suid rights (i.e. all mounts are cloned and
>       propagated with nosuid)
> 
>    2) Not giving up suid for cloned and propagated mounts, but having
>       extra limitations (suid/sgid programs cannot access unprivileged
>       "synthetic" mounts)

Although I hate special cases I think that we might need 2) to avoid too
much trouble tripping over the global namespace.  OTOH that should also
accelarate adoption of giving each user a separate namespace on login in
the various distribution, which is a good thing ;-)

