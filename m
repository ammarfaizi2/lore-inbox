Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263336AbTDCJiq>; Thu, 3 Apr 2003 04:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263337AbTDCJiq>; Thu, 3 Apr 2003 04:38:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:58850 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S263336AbTDCJio>; Thu, 3 Apr 2003 04:38:44 -0500
X-Envelope-From: kraxel@bytesex.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Frank Davis <fdavis@si.rr.com>
Subject: Re: [patch] add i2c_clients_command()
References: <20030402170652.GA24954@bytesex.org>
	<20030402190852.B1091@infradead.org>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SuSE Labs, Berlin
Date: 03 Apr 2003 10:49:53 +0200
In-Reply-To: <20030402190852.B1091@infradead.org>
Message-ID: <87llysc6dq.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> > +void i2c_clients_command(struct i2c_adapter *adap, unsigned int cmd, void *arg)
> > +{
> > +	int i;
> > +
> > +	down(&adap->list);
> > +	for (i = 0; i < I2C_CLIENT_MAX; i++) {
> > +		if (NULL == adap->clients[i])
> > +			continue;

> This is a horrible algorithm!  Please introduce a per-adapter client
> lists.

Well, I can't easily fix that single function.  The whole i2c core
manages the clients that way, i.e. the whole i2c subsystem would need
a rewrite ...

  Gerd

-- 
Michael Moore for president!
