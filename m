Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267603AbTACRkw>; Fri, 3 Jan 2003 12:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbTACRja>; Fri, 3 Jan 2003 12:39:30 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:62704 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267605AbTACRjZ>; Fri, 3 Jan 2003 12:39:25 -0500
Date: Fri, 3 Jan 2003 12:47:54 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Stephen Evanchik <evanchsa@clarkson.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.54] hermes: serialization fixes
Message-ID: <20030103124754.A16519@redhat.com>
References: <200301031239.29226.evanchsa@clarkson.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301031239.29226.evanchsa@clarkson.edu>; from evanchsa@clarkson.edu on Fri, Jan 03, 2003 at 12:39:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2003 at 12:39:29PM -0500, Stephen Evanchik wrote:
> The hermes MAC controller module wasn't serializing BAP seek calls. This 
> caused an eventual Rx/Tx failure which equates tens of thousands of errors on 
> the wireless interface. A simple spinlock is used to keep things in line.
> 
> Any comments are appreciated, I don't believe this is the best solution, but 
> it is working well. Patches can be downloaded from here:

Why not put the spinlock/unlock inside hermes_bap_seek()?  Smaller, better 
contained and more readable.

		-ben
