Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292718AbSCMIXg>; Wed, 13 Mar 2002 03:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292728AbSCMIXR>; Wed, 13 Mar 2002 03:23:17 -0500
Received: from ns.suse.de ([213.95.15.193]:14603 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292718AbSCMIXP>;
	Wed, 13 Mar 2002 03:23:15 -0500
Date: Wed, 13 Mar 2002 09:23:06 +0100
From: Andi Kleen <ak@suse.de>
To: David Schwartz <davids@webmaster.com>
Cc: ak@suse.de, Brad Pepers <brad@linuxcanada.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Multi-threading
Message-ID: <20020313092306.A5570@wotan.suse.de>
In-Reply-To: <20020312081002.A14745@wotan.suse.de> <20020313075135.AAA25107@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313075135.AAA25107@shell.webmaster.com@whenever>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:51:29PM -0800, David Schwartz wrote:
> 
> >Just it might change immediately afterwards if you don't remove the
> >object from public view first.
> 
> 	If it was in public view, whatever held it in public view would be using it,
> and hence its use count could not drop to zero.

That's not correct at least in the usual linux kernel pattern of using
reference counts for objects. Hash tables don't hold reference counts,
only users do. If you think about it a hash table or global list holding
a reference count doesn't make too much sense.

-Andi
