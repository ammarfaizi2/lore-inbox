Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbTDBJxR>; Wed, 2 Apr 2003 04:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262956AbTDBJxR>; Wed, 2 Apr 2003 04:53:17 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:23014 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262955AbTDBJxQ>; Wed, 2 Apr 2003 04:53:16 -0500
Date: Wed, 2 Apr 2003 12:04:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Rohland <cr@sap.com>
Cc: tomlins@cam.org, CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030402100428.GA2661@wohnheim.fh-wedel.de>
References: <fa.eagpkml.m3elbd@ifi.uio.no> <20030401133833.6C71DF3D@oscar.casa.dyndns.org> <ovk7eekwsc.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ovk7eekwsc.fsf@sap.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 April 2003 18:27:47 +0200, Christoph Rohland wrote:
> 
> I agree and I think if you add this option it should adjust to a
> percentage of (ram + swap). With this it would be a really nice
> improvement.
> I even had patches for this but to do it efficently you would need to
> add some hooks to swapon and swapoff.

Which means we have two orthogonal problems to deal with. Adding the
percent option and "fixing" it to take swap into account.

Not completely orthogonal, though, since the "fix" actually changes
semantics and might break some peoples setups. Take 3x50% of RAM and
twice the RAM as swap, for example.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown
