Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311782AbSCXSnV>; Sun, 24 Mar 2002 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311786AbSCXSnM>; Sun, 24 Mar 2002 13:43:12 -0500
Received: from ns.suse.de ([213.95.15.193]:39952 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311782AbSCXSm7>;
	Sun, 24 Mar 2002 13:42:59 -0500
Date: Sun, 24 Mar 2002 19:42:54 +0100
From: Dave Jones <davej@suse.de>
To: Boris Bezlaj <boris@kista.gajba.net>
Cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups
Message-ID: <20020324194254.A14465@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Boris Bezlaj <boris@kista.gajba.net>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323164220.742414d2.boris@kista.gajba.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 04:42:20PM +0100, Boris Bezlaj wrote:

 >  	if (! mda_detect()) {
 > -		printk("mdacon: MDA card not detected.\n");
 > +		printk(KERN_WARNING __FILE__ ": MDA card not detected.\n");
 >  		return NULL;

Does __FILE__ suffer the same 'deprecated' warning that newer gcc 3's
spit out for __FUNCTION__  ? If so, it'd be better to do this properly
than to add more bits that will just create another janitor item for
someone else later..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
