Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTFDUDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTFDUDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:03:40 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65478
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264027AbTFDUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:03:39 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andrew Morton <akpm@digeo.com>,
       "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Subject: Union mounts (was: Re: sysfs-diskstat)
Date: Wed, 4 Jun 2003 16:19:38 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B014052AC@mesadm.epl.prov-liege.be> <20030604021716.0b2a121a.akpm@digeo.com>
In-Reply-To: <20030604021716.0b2a121a.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306041619.38928.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 05:17, Andrew Morton wrote:
> "Frederick, Fabian" <Fabian.Frederick@prov-liege.be> wrote:
> > Hi !
> >
> > 	Someone could tell me if the proc/diskstat stuff will be kept in 2.6
> > and above or do we have to refer _only_
> >  to sysfs by now ?
>
> death, taxes and /proc/diskstats.  It ain't going away.

Out of morbid curiosity, what's the status of union mounts?  I've had this 
sneaking suspicion that /proc would eventually be broken up into two 
filesystems: 1) what /proc was originally meant for (a subdirectory for each 
pid), 2) all the extra crap that got shoehorned into it back when it was the 
only synthetic filesystem (and after everybody got into the habit of putting 
synthetic fs stuff into /proc).

Of course making this work with legacy tools would require union mounting both 
procfs and crapfs onto /proc.  Which gets us back to "how are union mounts 
doing"?

Rob

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

