Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318475AbSGaUI7>; Wed, 31 Jul 2002 16:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318485AbSGaUI7>; Wed, 31 Jul 2002 16:08:59 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:45323 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318475AbSGaUI6>; Wed, 31 Jul 2002 16:08:58 -0400
Date: Wed, 31 Jul 2002 21:12:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020731211221.A23228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20020731131620.M15238@lustre.cfs> <20020731202638.A22765@infradead.org> <20020731230412.B1237@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020731230412.B1237@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Wed, Jul 31, 2002 at 11:04:12PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 11:04:12PM +0300, Matti Aarnio wrote:
>   It depends on many things:
>    - Block layer (unsigned long)
>    - Page indexes (unsigned long)

That grows with sizeof(unsigned long) on 64bit machines.  And for the
filesystem internals just use one that is designed to be used with that
big storage devices (e.g. jfs or xfs ceratainly not ext2/3 or reiserfs3).

