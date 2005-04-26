Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVDZKIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDZKIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVDZKIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:08:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261466AbVDZKEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:04:22 -0400
Date: Tue, 26 Apr 2005 11:04:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org, jamie@shareable.org,
       linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426100412.GA30762@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Miklos Szeredi <miklos@szeredi.hu>,
	jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
	bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426030010.63757c8c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426030010.63757c8c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:00:10AM -0700, Andrew Morton wrote:
> Not as thick as mine!  Could someone please explain in small words what's
> wrong with an suid mount helper?

Nothing per-se.  What makes it bad is the contect of a userland filesystem
where the actual filesystem operations in the mounted filesystem happen
in contect of a non-privilegued user.
