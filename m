Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVKPA0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVKPA0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 19:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVKPA0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 19:26:40 -0500
Received: from web50106.mail.yahoo.com ([206.190.38.34]:60262 "HELO
	web50106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965109AbVKPA0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 19:26:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Dgaan6aejI0IhR7BLDhhYRn3f7fAxk3GMfIwsJ2zEhzehvshxq6A6vY/dHzk1OE8FzHEsKMsGZR7vuF9kXA/Pxg9JcdZ8KOV9F6djQLpvC2QPKbo0XJ+wBR5QgkrSyduzLF51u9FxCkdP7kXtUMDwPliUiumGhabQOAJNyv/RLY=  ;
Message-ID: <20051116002638.762.qmail@web50106.mail.yahoo.com>
Date: Tue, 15 Nov 2005 16:26:38 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [RFC] EDAC and the sysfs
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051115172528.GB13658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:

> On Mon, Nov 14, 2005 at 04:47:03PM -0800, Doug
> Thompson wrote:
> > For each Chip-Select Row (csrow) there would be
> > information. I am still trying to determine if
> each
> > csrow would be in its own directory or all cwrows
> just
> > flat in the mc0, mc1, ... directories. 
> > 
> > Assuming each csrow is in its own directory (which
> is
> > the way I am leaning) below:
> > 
> > csrow0/
> > csrow1/
> > csrow2/
> > csrow3/
> > ...
> > 
> > info files in the above directories:
> > 
> > memory_size
> > memory_type
> > device_type
> > edac_mode
> > ue_count
> > ce_count
> > ce_count_channel_0
> > ce_count_channel_1
> > dimm_label
> > dimm_label_channel_0
> > dimm_label_channel_1
> > 
> 
> Ok, thanks for the details, it makes more sense now.
>  Your heirachy
> seems sane, have you implemented it to see if it
> works properly?

I began implementing first in /sys/classes and that is
when I ran into the nested class issue. I then looked
at the /sys/devices/system interface point and then
sought more information and then ASKED for RFC from
the list.

I will now use the /sys/devices/system/edac as my root
for my files and controls.

Speaking of controls, edac has them  currently in
/proc/sys/mc. I have proposed to have them in
/sys/devices/system/edac/mc and friends. 

My question is:  Should I remove entirely my old
/proc/sys/mc sysctl tree? Or still maintain the
aliases there (which seems weird)? 

If I do that, then /etc/sysctl.conf will no longer
allow for setting things up there.

Is there going to be a similiar functionality as
/etc/sysctl.conf for those items we place in sysfs, in
the future?

thanks

doug t

PS. These questions on sysfs seem a perfect food
stream for your 'HOWTO do kernel development'. Trying
to do new entries in sysfs has been a painstaking
adventure. After googling the web for info, it
definitely has been a bit thin on information on sysfs
at the level I am seeking.

> 
> thanks,
> 
> greg k-h
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

