Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbSKSTeB>; Tue, 19 Nov 2002 14:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSKSTeB>; Tue, 19 Nov 2002 14:34:01 -0500
Received: from holomorphy.com ([66.224.33.161]:27878 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267133AbSKSTeA>;
	Tue, 19 Nov 2002 14:34:00 -0500
Date: Tue, 19 Nov 2002 11:38:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Oracle 9.2 OOMs again at startup in 2.5.4[78]
Message-ID: <20021119193807.GN23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alessandro Suardi <alessandro.suardi@oracle.com>,
	Andrew Morton <akpm@digeo.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, pbadari@us.ibm.com
References: <3DDA4921.30403@oracle.com> <3DDA88F9.41F41CB9@digeo.com> <3DDA8C18.1000903@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDA8C18.1000903@oracle.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 08:08:08PM +0100, Alessandro Suardi wrote:
> The patch you actually include seems to be a combination of
>     ChangeSet 1.373.204.73 2002/05/28 22:01:57 torvalds@home.transmeta.com
>       Remove re-use of "struct mm_struct" at execve() time.
>       This will eventually allow us to copy argc/argv without
>       any intermediate storage (removing current argument size
>       limitations).
> and
>     ChangeSet 1.373.221.1 2002/05/28 22:55:46 torvalds@home.transmeta.com
>       Allocate new mm_struct for execve() early, so that we have
>       access to it by the time we start copying arguments.

This created some unusual startup problems for DB2 also, but they went
away (for DB2) before anyone had figured out why they caused a startup
failure. ISTR badari dealing with this more directly (hence the cc:).

badari, do you remember more of what happened?


Thanks,
Bill
