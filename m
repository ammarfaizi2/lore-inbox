Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWAVEAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWAVEAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 23:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWAVEAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 23:00:19 -0500
Received: from xenotime.net ([66.160.160.81]:34488 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932408AbWAVEAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 23:00:18 -0500
Date: Sat, 21 Jan 2006 20:00:23 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tali@admingilde.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] kernel-doc: clean up the script (whitespace)
Message-Id: <20060121200023.4077669b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Remove lots of trailing whitespace.  Nothing else.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |   68 ++++++++++++++++++++++++++---------------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

--- linux-2616-rc1-secur.orig/scripts/kernel-doc
+++ linux-2616-rc1-secur/scripts/kernel-doc
@@ -90,28 +90,28 @@ use strict;
 #  * my_function - does my stuff
 #  * @my_arg: its mine damnit
 #  *
-#  * Does my stuff explained. 
+#  * Does my stuff explained.
 #  */
 #
 #  or, could also use:
 # /**
 #  * my_function - does my stuff
 #  * @my_arg: its mine damnit
-#  * Description: Does my stuff explained. 
+#  * Description: Does my stuff explained.
 #  */
 # etc.
 #
-# Beside functions you can also write documentation for structs, unions, 
-# enums and typedefs. Instead of the function name you must write the name 
-# of the declaration;  the struct/union/enum/typedef must always precede 
-# the name. Nesting of declarations is not supported. 
+# Beside functions you can also write documentation for structs, unions,
+# enums and typedefs. Instead of the function name you must write the name
+# of the declaration;  the struct/union/enum/typedef must always precede
+# the name. Nesting of declarations is not supported.
 # Use the argument mechanism to document members or constants.
 # e.g.
 # /**
 #  * struct my_struct - short description
 #  * @a: first member
 #  * @b: second member
-#  * 
+#  *
 #  * Longer description
 #  */
 # struct my_struct {
@@ -122,12 +122,12 @@ use strict;
 # };
 #
 # All descriptions can be multiline, except the short function description.
-# 
-# You can also add additional sections. When documenting kernel functions you 
-# should document the "Context:" of the function, e.g. whether the functions 
+#
+# You can also add additional sections. When documenting kernel functions you
+# should document the "Context:" of the function, e.g. whether the functions
 # can be called form interrupts. Unlike other sections you can end it with an
-# empty line. 
-# Example-sections should contain the string EXAMPLE so that they are marked 
+# empty line.
+# Example-sections should contain the string EXAMPLE so that they are marked
 # appropriately in DocBook.
 #
 # Example:
@@ -135,7 +135,7 @@ use strict;
 #  * user_function - function that can only be called in user context
 #  * @a: some argument
 #  * Context: !in_interrupt()
-#  * 
+#  *
 #  * Some description
 #  * Example:
 #  *    user_function(22);
@@ -223,9 +223,9 @@ my %highlights = %highlights_man;
 my $blankline = $blankline_man;
 my $modulename = "Kernel API";
 my $function_only = 0;
-my $man_date = ('January', 'February', 'March', 'April', 'May', 'June', 
-		'July', 'August', 'September', 'October', 
-		'November', 'December')[(localtime)[4]] . 
+my $man_date = ('January', 'February', 'March', 'April', 'May', 'June',
+		'July', 'August', 'September', 'October',
+		'November', 'December')[(localtime)[4]] .
   " " . ((localtime)[5]+1900);
 
 # Essentially these are globals
@@ -236,7 +236,7 @@ my ($function, %function_table,%paramete
 my ($type,$declaration_name,$return_type);
 my ($newsection,$newcontents,$prototype,$filelist, $brcount, %source_map);
 
-# Generated docbook code is inserted in a template at a point where 
+# Generated docbook code is inserted in a template at a point where
 # docbook v3.1 requires a non-zero sequence of RefEntry's; see:
 # http://www.oasis-open.org/docbook/documentation/reference/html/refentry.html
 # We keep track of number of generated entries and generate a dummy
@@ -365,7 +365,7 @@ sub dump_section {
 #  parameterdescs => %parameter descriptions
 #  sectionlist => @list of sections
 #  sections => %descriont descriptions
-#  
+#
 
 sub output_highlight {
     my $contents = join "\n",@_;
@@ -400,7 +400,7 @@ sub output_section_html(%) {
 	print "<blockquote>\n";
 	output_highlight($args{'sections'}{$section});
 	print "</blockquote>\n";
-    }  
+    }
 }
 
 # output enum in html
@@ -551,7 +551,7 @@ sub output_intro_html(%) {
 
 sub output_section_xml(%) {
     my %args = %{$_[0]};
-    my $section;    
+    my $section;
     # print out each section
     $lineprefix="   ";
     foreach $section (@{$args{'sectionlist'}}) {
@@ -778,7 +778,7 @@ sub output_enum_xml(%) {
     print "</refsynopsisdiv>\n";
 
     print "<refsect1>\n";
-    print " <title>Constants</title>\n";    
+    print " <title>Constants</title>\n";
     print "  <variablelist>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
       my $parameter_name = $parameter;
@@ -1157,7 +1157,7 @@ sub output_section_text(%) {
     foreach $section (@{$args{'sectionlist'}}) {
 	print "$section:\n\n";
 	output_highlight($args{'sections'}{$section});
-    }  
+    }
     print "\n\n";
 }
 
@@ -1262,8 +1262,8 @@ sub output_declaration {
     my $name = shift;
     my $functype = shift;
     my $func = "output_${functype}_$output_mode";
-    if (($function_only==0) || 
-	( $function_only == 1 && defined($function_table{$name})) || 
+    if (($function_only==0) ||
+	( $function_only == 1 && defined($function_table{$name})) ||
 	( $function_only == 2 && !defined($function_table{$name})))
     {
         &$func(@_);
@@ -1282,7 +1282,7 @@ sub output_intro {
 }
 
 ##
-# takes a declaration (struct, union, enum, typedef) and 
+# takes a declaration (struct, union, enum, typedef) and
 # invokes the right handler. NOT called for functions.
 sub dump_declaration($$) {
     no strict 'refs';
@@ -1352,7 +1352,7 @@ sub dump_enum($$) {
 	    }
 
 	}
-	
+
 	output_declaration($declaration_name,
 			   'enum',
 			   {'enum' => $declaration_name,
@@ -1409,7 +1409,7 @@ sub create_parameterlist($$$) {
     while ($args =~ /(\([^\),]+),/) {
         $args =~ s/(\([^\),]+),/$1#/g;
     }
-    
+
     foreach my $arg (split($splitter, $args)) {
 	# strip comments
 	$arg =~ s/\/\*.*\*\///;
@@ -1556,7 +1556,7 @@ sub dump_function($$) {
 	return;
     }
 
-    output_declaration($declaration_name, 
+    output_declaration($declaration_name,
 		       'function',
 		       {'function' => $declaration_name,
 			'module' => $modulename,
@@ -1615,11 +1615,11 @@ sub reset_state {
     %sections = ();
     @sectionlist = ();
     $prototype = "";
-    
+
     $state = 0;
 }
 
-sub process_state3_function($$) { 
+sub process_state3_function($$) {
     my $x = shift;
     my $file = shift;
 
@@ -1638,7 +1638,7 @@ sub process_state3_function($$) { 
     }
 }
 
-sub process_state3_type($$) { 
+sub process_state3_type($$) {
     my $x = shift;
     my $file = shift;
 
@@ -1778,7 +1778,7 @@ sub process_file($) {
 	    } elsif (/$doc_content/) {
 		# miguel-style comment kludge, look for blank lines after
 		# @parameter line to signify start of description
-		if ($1 eq "" && 
+		if ($1 eq "" &&
 			($section =~ m/^@/ || $section eq $section_context)) {
 		    dump_section($section, xml_escape($contents));
 		    $section = $section_default;
@@ -1788,7 +1788,7 @@ sub process_file($) {
 		}
 	    } else {
 		# i dont know - bad line?  ignore.
-		print STDERR "Warning(${file}:$.): bad line: $_"; 
+		print STDERR "Warning(${file}:$.): bad line: $_";
 		++$warnings;
 	    }
 	} elsif ($state == 3) {	# scanning for function { (end of prototype)
@@ -1843,7 +1843,7 @@ sub process_file($) {
 			else
 			{
 				$contents .= $1 . "\n";
-			}	
+			}
         	}
           }
     }


---
