Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJAFb3>; Tue, 1 Oct 2002 01:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJAFb3>; Tue, 1 Oct 2002 01:31:29 -0400
Received: from [208.48.139.185] ([208.48.139.185]:10678 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S261492AbSJAFb2>; Tue, 1 Oct 2002 01:31:28 -0400
Date: Mon, 30 Sep 2002 22:36:49 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Message-ID: <20020930223649.A20225@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
References: <0EBC45FCABFC95428EBFC3A51B368C9501AF4F@jessica.herefordshire.gov.uk> <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>; from Whitewlf@Whitewlf.net on Wed, Sep 25, 2002 at 04:16:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can second the PHPA recommendation.  Since you appear to be CPU bound
doing a lot of processing in httpd, anything you can do to speed them up
will help.  PHPA showed significant performance increases in my tests.

-Dave

On Wed, Sep 25, 2002 at 04:16:47PM -0400, Adam Goldstein wrote:
> During my investigation of php accelerator (which we put off before 
> thinking it would be better to stabilize the server first) I came 
> across a small blurb about php 4.1.2 (which we use) and mysql.
> 
> http://www.php-accelerator.co.uk/faq.php#segv2
> 
> Apparently this is how the site is written in some places, and it 
> causes instability in the php portion of the apache process. We are 
> fixing this now. Also, with the nodiratime, noatime, ext2 combination, 
> the load has decreased a little, but, not very much. It has still 
> reached >25 load when apache processes reached 120 (112 active 
> according to server-status) and page loads come to near dead stop... 
> segfaults still exist, even with fixed mysql connection calls. :(      
> 1-4/min under present  25+ load.
> 
> As for the syslog, unfort. almost every entry was marked async. I 
> changed an auth log entry but messages was already async. I left 
> kernel.errors sync, as It never really logs.
> 
> On Wednesday, September 25, 2002, at 04:55 AM, Randal, Phil wrote:
> 
> > Have you tried using PHP Accelerator?
> >
> > It's the only free PHP Cache which has survived my testing,
> > and should certainly reduce your CPU load.
