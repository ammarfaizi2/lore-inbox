Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUFHVRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUFHVRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUFHVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:17:46 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:11689 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265325AbUFHVRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:17:32 -0400
Date: Tue, 8 Jun 2004 23:08:09 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-ID: <20040608210809.GA10542@k3.hellgate.ch>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607145723.41da5783.davem@redhat.com>
X-Operating-System: Linux 2.6.7-rc1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2004 14:57:23 -0700, David S. Miller wrote:
> On Mon, 7 Jun 2004 23:28:04 +0200
> Roger Luethi <rl@hellgate.ch> wrote:
> 
> > What is the correct response if a user passes ethtool speed or duplex
> > arguments while autoneg is on? Some possible answers are:
> > 
[...]
> speed and duplex fields should be silently ignored in this case

It may not matter much because few people care about forced media these
days. And it is debatable whether trying to guess the users intention
is a good idea (we lack means for users to manipulate autoneg results
via advertisted values but that's no big deal).

However, "silently ignoring" strikes me as a very poor choice, in
stark contrast to Unix/Linux tradition. A user issues a command which
cannot be executed and gets the same response that is used to indicate
success!? What school of user interface design is that? How is that
not confusing users? </rant>

Roger
