Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276892AbRJCHHs>; Wed, 3 Oct 2001 03:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276895AbRJCHHi>; Wed, 3 Oct 2001 03:07:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64192 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276892AbRJCHH2>;
	Wed, 3 Oct 2001 03:07:28 -0400
Date: Wed, 3 Oct 2001 03:07:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <01100222550205.02611@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0110030306200.21861-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Oct 2001, Rob Landley wrote:

> Anybody want to venture an opinion why overwriting executable files that are 
> currently in use gives you a "text file busy" error, but overwriting shared 
> libraries that are in use apparently works just fine (modulo a core dump if 
> you aren't subtle about your run-time patching)?
> 
> Permissions are still enforced, but it seems to me somebody who cracks root 
> on a system could potentially modify the behavior of important system daemons 
> without changing their process ID numbers.
> 
> Did I miss something somewhere?

Somebody who cracks root can attach gdb to a daemon, modify the contents of
its text segment and detach.  No need to change any files...

