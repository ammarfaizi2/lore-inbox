Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRBTBvu>; Mon, 19 Feb 2001 20:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRBTBva>; Mon, 19 Feb 2001 20:51:30 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:5636 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129131AbRBTBv1>; Mon, 19 Feb 2001 20:51:27 -0500
Date: Tue, 20 Feb 2001 14:51:24 +1300
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sendfile64?
Message-ID: <20010220145123.A1609@metastasis.f00f.org>
In-Reply-To: <20010220015518.B12073@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220015518.B12073@convergence.de>; from leitner@convergence.de on Tue, Feb 20, 2001 at 01:55:18AM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Why isn't there a sendfile64?

because nobody has implemented on -- arguably it's not needed; the
different between:

	sendfile64(...)

and

	while(blah){
		sendfile( ... 1G or so ...)
	}

probably won't be detectable anyhow. I see no reason why sendfile64
should be purely user-space (then again, I see no reason why not to
extend the kernel API as is, but last time I tested it is was busted
WRT signals so I would rather that be fixed before further
proliferation there).



  --cw
