Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWCMS33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWCMS33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWCMS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:29:29 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:46863 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S932068AbWCMS32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:29:28 -0500
Date: Mon, 13 Mar 2006 18:23:31 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: thockin@hockin.org
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] natsemi: Add support for using MII port with no PHY
Message-ID: <20060313182331.GA19014@sirena.org.uk>
Mail-Followup-To: thockin@hockin.org, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060312192259.929734000@mercator.sirena.org.uk> <20060312205303.869316000@mercator.sirena.org.uk> <20060312214113.GA15071@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312214113.GA15071@hockin.org>
X-Cookie: All men have the right to wait in line.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 01:41:13PM -0800, thockin@hockin.org wrote:

> Not that my opinion should hold much weight, having been absent from the
> driver for some time, but yuck.  Is there no better way to do this thatn
> sprinkling poo all over it?

The changes are mostly isolated into check_link(), the fact that half
the function gets placed inside a conditional but diff sees it as a
bunch of smaller changes makes the changes look a lot more invasive than
they actually are.  I guess that could be helped by splitting the PHY
access code out of check_link() into check_phy_status() or something but
I'm not sure how much that really helps.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
