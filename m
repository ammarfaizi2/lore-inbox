Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTJQMdt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTJQMdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:33:49 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:36224 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263434AbTJQMdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:33:47 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 17 Oct 2003 08:33:44 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017123344.GA2794@ncsu.edu>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017094443.GA7738@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017094443.GA7738@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:44:44AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Several months ago we encountered the hash collision problem
> > with rsync.  This brought about a fair amount of discussion
> 
> So you found collision in something like md5 or sha1?

No, rsync uses a much weaker hash.  The paper on the rsync alg is
interesting and has all the details, so you should read if if you
want to be sure.  But from my memory rsync uses a combination of
a weak 16 bit hash which it rolls through the data, and a strong
32 bit hash which it uses to check the 16 bit hash.
