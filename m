Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVCNXWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVCNXWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCNXU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:20:57 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:27526 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262068AbVCNXTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:19:31 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: script to send changesets per mail
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Martin Waitz <tali@admingilde.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 15 Mar 2005 00:22:56 +0100
References: <fa.f2usg94.a5sd8q@ifi.uio.no> <fa.hdaug7i.n7qkqg@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DAytl-00026G-S2@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:

> sub make_message_id
> {
> my $date = `date "+\%s"`;
> chomp($date);
> my $pseudo_rand = int (rand(4200));
> $message_id = "<$date$pseudo_rand\@kroah.com>";
> print "new message id = $message_id\n";
> }

Why not

use Email::MessageID;
use Net::Domain qw(hostfqdn);

sub make_message_id()
{
        return Email::MessageID->new(host => hostfqdn());
}

