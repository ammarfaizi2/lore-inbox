Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTADF3V>; Sat, 4 Jan 2003 00:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbTADF3V>; Sat, 4 Jan 2003 00:29:21 -0500
Received: from dp.samba.org ([66.70.73.150]:19155 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261354AbTADF3U>;
	Sat, 4 Jan 2003 00:29:20 -0500
Date: Sat, 4 Jan 2003 16:38:01 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Stephen Evanchik <evanchsa@clarkson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.54] UPDATE hermes: serialization fixes
Message-ID: <20030104053801.GF20016@zax.zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Stephen Evanchik <evanchsa@clarkson.edu>,
	linux-kernel@vger.kernel.org
References: <200301031550.55590.evanchsa@clarkson.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301031550.55590.evanchsa@clarkson.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 03:50:55PM -0500, Stephen Evanchik wrote:
> This fixes "Error -110 writing Tx descriptor to BAP" bug as referenced in David Gibson's README.
> 
> As per a suggestion, I've moved the spin_lock/unlock to hermes_bap_seek(). I'm currently running with
> this module and it's working nicely. 
> 
> As always, any comments are appreciated. Patches can be always downloaded from here:

I don't see how this can make any difference on the 0.13 and later
versions of the driver (which is in 2.5), since all BAP operations are
already serialized by the lock in the orinoco_private structure.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
