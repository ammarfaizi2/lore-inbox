Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281436AbRKHGtN>; Thu, 8 Nov 2001 01:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281255AbRKHGtD>; Thu, 8 Nov 2001 01:49:03 -0500
Received: from ns.suse.de ([213.95.15.193]:64772 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278709AbRKHGss>;
	Thu, 8 Nov 2001 01:48:48 -0500
Date: Thu, 8 Nov 2001 07:48:43 +0100
From: Andi Kleen <ak@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, acl-devel@bestbits.at,
        linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] extended attributes
Message-ID: <20011108074843.A11858@wotan.suse.de>
In-Reply-To: <20011107111224.C591676@wobbly.melbourne.sgi.com> <20011107023218.A4754@wotan.suse.de> <20011107141956.F591676@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011107141956.F591676@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Wed, Nov 07, 2001 at 02:19:56PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:19:56PM +1100, Nathan Scott wrote:
> I'm not sure this would work for the extattr/lextattr variants where
> we don't have an fd to hold the state.  Should the list operation

Right. I forgot that.

Then I guess it is better to use EA_LIST_SIZE / EA_GET_LIST (EAGAIN on race)

Whole point is to just avoid to have an stateless cursor. 

-Andi
