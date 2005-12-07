Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVLGJei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVLGJei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVLGJei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:34:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750726AbVLGJeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:34:37 -0500
Date: Wed, 7 Dec 2005 09:34:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Missing break in timedia serial setup.
Message-ID: <20051207093431.GB32365@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20051207010526.GA7258@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207010526.GA7258@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 08:05:26PM -0500, Dave Jones wrote:
> Spotted during code review by a Fedora user.
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=174967

Makes no difference.

        switch (idx) {
        case 3:
                bar = 1;
        case 4: /* BAR 2 */
        case 5: /* BAR 3 */
        case 6: /* BAR 4 */
        case 7: /* BAR 5 */
                bar = idx - 2;

If idx is 3, idx - 2 is 1.  So the bar = 1 is actually redundant in
case 3.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
