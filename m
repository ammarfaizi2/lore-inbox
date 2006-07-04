Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWGDId6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWGDId6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGDId6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:33:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23956 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932119AbWGDId5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:33:57 -0400
Message-ID: <44AA27DA.9070501@sgi.com>
Date: Tue, 04 Jul 2006 10:33:30 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Milton Miller <miltonm@bga.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	 <200607040516.k645GFTj014564@sullivan.realtime.net>	 <44AA1D09.7080308@sgi.com> <1151999591.3109.8.camel@laptopd505.fenrus.org>	 <44AA2301.2030400@sgi.com> <1152001399.3109.12.camel@laptopd505.fenrus.org>
In-Reply-To: <1152001399.3109.12.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-04 at 10:12 +0200, Jes Sorensen wrote:
>> Guess the question is, is there a way we can detect when media has
>> been
>> inserted without doing open/close on the device constantly? 
> 
> they could just keep the device open.... at least until media is
> inserted

Yup, I will see how much it requires to make it do that.

> also they should poll at most every 10 seconds; anything more frequent
> is just braindead...

But of course, then your camera's picture card isn't detected within a
microsecond of your inserting it into the cardreader! Really can't have
that!

Cheers,
Jes

