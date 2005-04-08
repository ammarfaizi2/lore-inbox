Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVDHIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVDHIFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVDHIB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:01:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60597 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262757AbVDHIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:00:02 -0400
Subject: Re: [PATCH] Use proper seq_file api for /proc/scsi/scsi
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeremy Higdon <jeremy@sgi.com>, Hannes Reinecke <hare@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050408075643.GA5514@infradead.org>
References: <42550173.1040503@suse.de> <20050407103123.GB9586@infradead.org>
	 <425517B3.2010702@suse.de> <20050407112412.GA12072@infradead.org>
	 <20050408072345.GA1018765@sgi.com>  <20050408075643.GA5514@infradead.org>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 09:59:57 +0200
Message-Id: <1112947198.6278.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 08:56 +0100, Christoph Hellwig wrote:
> On Fri, Apr 08, 2005 at 12:23:46AM -0700, Jeremy Higdon wrote:
> > > It works for those setups that already worked with 2.4.x, aka only a few
> > > luns.
> > 
> > Even if it's deprecated, wouldn't it be good to fix it as long as
> > it's there, unless it hurts something else?  Or at least fix the
> > out of memory error, even if it doesn't display all the luns?
> 
> What other error would you return?  I don't particularly care what exact
> error code to return, but putting in Hannes patch would be a bad idea because
> it
> 
>   a) poke deep into driver model internals, and we absolutely want to avoid
>      that
>   b) sets a bad precedence that we'll continue adding features to deprecated
>      interface and thus encurage people to contiue using it.  Note that
>      /proc/scsi/* has been deprecated since mid-2.5.x.


so how about starting to remove it?
eg give it its final resting date, start defaulting the config option to
"n" and such...


