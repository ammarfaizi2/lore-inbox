Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318679AbSG0CN3>; Fri, 26 Jul 2002 22:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318680AbSG0CN3>; Fri, 26 Jul 2002 22:13:29 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:11670 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318679AbSG0CN2>;
	Fri, 26 Jul 2002 22:13:28 -0400
From: cort@fsmlabs.com
Date: Fri, 26 Jul 2002 20:17:21 -0600
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726201721.B6370@cort.fsmlabs.com>
References: <1027726949.2691.68.camel@orca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027726949.2691.68.camel@orca>; from ray-lk@madrabbit.org on Fri, Jul 26, 2002 at 04:42:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, I'll add that to the comments for completeness.

I think this affects all Vaio laptops.  With enough reports maybe
we'll find out something different, though.

Thanks for the suggestion to move the get_event().  I'll see about moving
that (but not on a friday night).

} It looks like my Vaio will need it as well -- loading the apm module
} with debug=1 doesn't show any on/off battery events when I yank the
} power. (It does log other events, though.)
} 
} A comment on the patch? How about pushing the specifics of the
} apm_bios_power_change_bug from check_events() down into either the
} get_event() or apm_get_event() routines? That way the specifics are
} abstracted a bit from the main event dispatch loop, and one gets to
} inherit the debug logging and whatnot.
} 
} And, in case you decide to tighten up the dmi matching, my laptop info
} follows:
} 
} 	BIOS Information Block
} 		Vendor: Phoenix Technologies LTD
} 		Version: R0117A0
} 		Release: 04/25/00
} 	System Information Block
} 		Vendor: Sony Corporation    
} 		Product: PCG-XG29(UC)        
