Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTDQDlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTDQDlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:41:09 -0400
Received: from granite.he.net ([216.218.226.66]:16403 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262671AbTDQDlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:41:08 -0400
Date: Wed, 16 Apr 2003 20:54:31 -0700
From: Greg KH <greg@kroah.com>
To: Philippe =?iso-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then hard freeze ( lockup on CPU0)
Message-ID: <20030417035431.GA2201@kroah.com>
References: <20030416055402.GC15860@kroah.com> <Pine.LNX.4.44.0304160951160.912-100000@cherise> <20030417014051.60f6b9b3.philippe.gramoulle@mmania.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030417014051.60f6b9b3.philippe.gramoulle@mmania.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 01:40:51AM +0200, Philippe Gramoullé wrote:
> 
> Hello,
> 
> On Wed, 16 Apr 2003 09:58:36 -0700 (PDT)
> Patrick Mochel <mochel@osdl.org> wrote:
> 
>   | In short, I think we can remove the locks entirely. We can at least see 
>   | what happens.. 
> 
> Reverting Andrew's patch and applying yours resulted in not being able to boot:

Same for me, looks like people are grabbing this lock before it's
initialized :(

greg k-h
